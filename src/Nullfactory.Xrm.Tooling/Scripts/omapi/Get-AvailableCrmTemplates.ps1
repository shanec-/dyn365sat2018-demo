<#
    .SYNOPSIS
        Retrieve a list of Dynamics 365 Customer Engagement Application Templates.
    .DESCRIPTION
        Retrieve a list of Dynamics 365 Customer Engagement Applications Templates in the Office 365 tenant.
    .NOTES
        Author: Shane Carvalho
        Version: generator-nullfactory-xrm@1.6.0
    .LINK
        https://nullfactory.net
    .PARAMETER apiUrl
        The service api url.
    .PARAMETER username
        The username used to connect to the service API.
    .PARAMETER password
        The password used to connect.
    .EXAMPLE
        .\Get-AvailableCrmTemplates.ps1 -apiUrl "https://admin.services.crm6.dynamics.com" -username "admin@superinstance.onmicrosoft.com" -password "P@ssw0rd!"
        Retrieves a list of Dynamics 365 application templates in the tenant associated with username "admin@superinstance.onmicrosoft.com"
#>
[CmdletBinding(DefaultParameterSetName = "Internal")]
param(
    [Parameter(Mandatory = $true, Position = 1)]
    [ValidateSet('https://admin.services.crm.dynamics.com',
        'https://admin.services.crm9.dynamics.com',
        'https://admin.services.crm4.dynamics.com',
        'https://admin.services.crm5.dynamics.com',
        'https://admin.services.crm6.dynamics.com',
        'https://admin.services.crm7.dynamics.com',
        'https://admin.services.crm2.dynamics.com',
        'https://admin.services.crm8.dynamics.com',
        'https://admin.services.crm3.dynamics.com',
        'https://admin.services.crm11.dynamics.com')]
    [string]$apiUrl,
    [Parameter(Mandatory = $true, Position = 2)]
    [string]$username,
    [Parameter(Mandatory = $true, Position = 3)]
    [string]$password
)
$ErrorActionPreference = "Stop"

# Import common functions
. .\CrmInstance.Common.ps1
$creds = Init-OmapiModule $username $password

$crmTemplates = Get-AvailableCrmTemplates -ApiUrl $apiUrl -Credential $creds

# write out the templates
$crmTemplates | Where-Object { Write-Host $_.Name }