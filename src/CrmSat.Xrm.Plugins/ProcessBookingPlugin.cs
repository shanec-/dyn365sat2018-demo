using Microsoft.Xrm.Sdk;
using System;

namespace CrmSat.Xrm.Plugins
{
    public class ProcessBookingPlugin : IPlugin
    {
        public void Execute(IServiceProvider serviceProvider)
        {
            IPluginExecutionContext context =
                (IPluginExecutionContext)serviceProvider.GetService(typeof(IPluginExecutionContext));
            IOrganizationServiceFactory serviceFactory =
                (IOrganizationServiceFactory)serviceProvider.GetService(typeof(IOrganizationServiceFactory));
            IOrganizationService organizationService = serviceFactory.CreateOrganizationService(context.UserId);


            var booking = context.InputParameters["Target"] as Entity;
            var bookingImage = context.PreEntityImages["Image"] as Entity;

            var rentalModeId = (bookingImage["nfx_vehiclerentalmodeid"] as EntityReference);

            var rentalPeriod = (double)(bookingImage["nfx_rentalperiod"]);

            var vehicleRental = organizationService.Retrieve("nfx_vehiclerentalmode", rentalModeId.Id, new Microsoft.Xrm.Sdk.Query.ColumnSet("nfx_vehiclerentalmodeid", "nfx_priceperunit", "nfx_rentalmode"));
            var rentalMode = vehicleRental["nfx_rentalmode"] as OptionSetValue;
            var pricing = vehicleRental["nfx_priceperunit"] as Money;

            DateTime startDate = (DateTime)(bookingImage["nfx_startdate"]);
            DateTime endDate = startDate;
            decimal totalamount = pricing.Value * (decimal)rentalPeriod;

            switch (rentalMode.Value)
            {
                // hourly
                case (224820000):
                    endDate = startDate.AddHours((double)rentalPeriod);
                    break;
                // daily
                case (224820001):
                    endDate = startDate.AddDays((double)rentalPeriod);
                    break;
                // monthly
                case (224820002):
                    endDate = startDate.AddMonths((int)rentalPeriod);
                    break;
            }

            booking["nfx_enddate"] = endDate;
            booking["nfx_totalamount"] = new Money(totalamount);
        }
    }
}
