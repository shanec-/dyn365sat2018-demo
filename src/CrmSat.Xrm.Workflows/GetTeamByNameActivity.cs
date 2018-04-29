using System.Activities;
using System.Linq;
using Microsoft.Xrm.Sdk;
using Microsoft.Xrm.Sdk.Query;
using Microsoft.Xrm.Sdk.Workflow;

namespace CrmSat.Xrm.Workflows
{
    public class GetTeamByNameActivity : CodeActivity
    {
        [Input("Team Name")]
        [RequiredArgument]
        public InArgument<string> InputTeamName { get; set; }

        [Output("Team Id")]
        [ReferenceTarget("team")]
        public OutArgument<EntityReference> OutputTeam { get; set; }

        protected override void Execute(CodeActivityContext context)
        {
            var serviceFactory = context.GetExtension<IOrganizationServiceFactory>();
            var workflowContext = context.GetExtension<IWorkflowContext>();
            var organizationService = serviceFactory.CreateOrganizationService(workflowContext.UserId);
            var tracingService = context.GetExtension<ITracingService>();

            string teamName = this.InputTeamName.Get<string>(context);

            var queryExpression = new QueryExpression("team");
            queryExpression.Criteria.AddCondition("name", ConditionOperator.Equal, teamName);

            var results = organizationService.RetrieveMultiple(queryExpression);

            var team = results.Entities.FirstOrDefault();

            if(team != null)
            {
                OutputTeam.Set(context, new EntityReference("team", team.Id));
            }
        }
    }
}
