<#
  .SYNOPSIS
    Manually pull and extract CRM Solutions from remote servers.
  .DESCRIPTION
    Manually pull and extract CRM Solutions from configured remote servers.
	.NOTES
		Author: Shane Carvalho
		Version: generator-nullfactory-xrm@1.6.0
	.LINK
		https://nullfactory.net
#>

# Importing common functions
. .\CrmSolution.Common.ps1

# Defaulting to increased verbosity for manual execution
$oldverbose = $VerbosePreference
$VerbosePreference = "continue"

Write-Host "Attempting to pull solution(s)..."
try
{
  .\Pull-CrmSolution.ps1 `
    -serverUrl "https://sndbxdev.crm6.dynamics.com" `
    -username (Get-CrmUsername "CrmSat.VehicleBookingModule") `
    -password (Get-CrmPassword "CrmSat.VehicleBookingModule") `
    -solutionName "VehicleBookingModule" `
    -solutionRootFolder "..\..\CrmSat.VehicleBookingModule" `
    -solutionMapFile "..\..\Nullfactory.Xrm.Tooling\Mappings\VehicleBookingModule-mapping.xml"

  # Include a new entry for each CRM solution to be synced against a project folder

  # .\Pull-CrmSolution.ps1 `
  #   -serverUrl "http://servername/secondary" `
  #   -username (GetUsername "env_secondary_username_key") `
  #   -password (GetPassword "env_secondary_password_key") `
  #   -solutionName "secondary" `
  #   -solutionRootFolder "..\..\Demo.Solutions.Secondary" `
  #   -solutionMapFile "..\..\Nullfactory.Xrm.Tooling\Mappings\secondary-mapping.xml"

  Write-Host "Solution pull complete." -ForegroundColor Green
}
finally
{
	# Reset the verbosity to original level
	$VerbosePreference = $oldverbose
}
