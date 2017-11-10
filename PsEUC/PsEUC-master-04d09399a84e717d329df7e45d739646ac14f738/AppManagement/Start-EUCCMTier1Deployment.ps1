<#
.SYNOPSIS
    Deploy a tier 1 application to the organisation
.DESCRIPTION
    Using a staggered approach, the application will be deployed to the organisation using multiple device collections.
.EXAMPLE
    Start-EUCCMTier1Deployment -ApplicationName 'Microsoft Visual Studio 2015 Professional 15.0.22.2'
#>
function Start-EUCCMTier1Deployment
{
    [CmdletBinding()]
    Param
    (
        # The full name of the application to use for the deployment
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, Position=0)]
        [string]$ApplicationName
    )

    $deployToLatestDateTime = Get-Date
    $deployToEarlyAdopterStartDateTime = Get-DateInFutureByDays -Time '10:00am' -Days 2 -WorkWeekOnly
    $deployToEarlyAdopterDeadlinetDateTime = Get-DateInFutureByDays -Time '10:00am' -Days 3 -WorkWeekOnly
    $deployToProductionStartDateTime = Get-DateInFutureByDays -Time '10:00am' -Days 7 -WorkWeekOnly
    $deployToProductionDeadlineDateTime = Get-DateInFutureByDays -Time '10:00am' -Days 14 -WorkWeekOnly

    Start-CMApplicationDeployment -Name $ApplicationName -CollectionName 'BCC MOEvNext - Windows 10 - PRODX OU - Latest Branch Devices' -AvailableDateTime $deployToLatestDateTime -DeadlineDateTime $($deployToLatestDateTime.AddHours(24)) -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required -UserNotification DisplaySoftwareCenterOnly
    
    Start-CMApplicationDeployment -Name $ApplicationName -CollectionName 'BCC MOEvNext - Windows 10 - PRODX OU - Early Adopter Devices' -AvailableDateTime $deployToEarlyAdopterStartDateTime -DeadlineDateTime $deployToEarlyAdopterDeadlinetDateTime -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required -UserNotification DisplaySoftwareCenterOnly
    
    Start-CMApplicationDeployment -Name $ApplicationName -CollectionName 'BCC MOEvNext - Windows 10 - PRODX OU' -AvailableDateTime $deployToProductionStartDateTime -DeadlineDateTime $deployToProductionDeadlineDateTime -TimeBaseOn LocalTime -DeployAction Install -DeployPurpose Required -UserNotification DisplaySoftwareCenterOnly
}
