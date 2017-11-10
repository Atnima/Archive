function New-EUCCMDeviceCollection
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$Vendor,
        [Parameter(Mandatory=$true)]
        [string]$Name,
        [Parameter(Mandatory=$true)]
        [string]$ApplicationFullName,
        [Parameter(Mandatory=$true)]
        [int]$Tier,
        [switch]$Dynamic


    )

    if ($Dynamic) {
        $currentDate = $(Get-Date -Hour 10 -Minute $(Get-Random -Maximum 59 -Minimum 0) -Second 0)

        for ($i=1; $i -le 7; $i++) {
            if ($currentDate.AddDays($i).DayOfWeek -eq 'Saturday') {
                $currentDate.AddDays($i)
                break
            }
        }
        
        $schedule = New-CMSchedule -Start $currentDate -RecurCount 4 -RecurInterval Hours
        $collection = New-CMDeviceCollection -LimitingCollectionId 'SMS00001' -Name "App Deploy - $Vendor $Name" -RefreshType Periodic -RefreshSchedule $schedule
    }
    else {
        if ($Tier -eq 2) {
            $schedule = New-CMSchedule -Start $(Get-Date -Hour 8 -Minute $(Get-Random -Maximum 59 -Minimum 0) -Second 0) -RecurCount 4 -RecurInterval Hours
            $uninstallSchedule = New-CMSchedule -Start $(Get-Date -Hour 10 -Minute $(Get-Random -Maximum 59 -Minimum 0) -Second 0) -RecurCount 4 -RecurInterval Hours
        }
        else {
            $schedule = New-CMSchedule -Start $(Get-Date -Hour 9 -Minute $(Get-Random -Maximum 59 -Minimum 0) -Second 0) -RecurCount 4 -RecurInterval Hours
            $uninstallSchedule = New-CMSchedule -Start $(Get-Date -Hour 10 -Minute $(Get-Random -Maximum 59 -Minimum 0) -Second 0) -RecurCount 4 -RecurInterval Hours
        }

        $collection = New-CMDeviceCollection -LimitingCollectionId 'SMS00001' -Name "App Deploy - $Vendor $Name" -RefreshType Periodic -RefreshSchedule $schedule
        $uninstallCollection = New-CMDeviceCollection -LimitingCollectionId 'SMS00001' -Name "Uninstall - $Vendor $Name" -RefreshType Periodic -RefreshSchedule $uninstallSchedule
    }

    New-ADGroup -DisplayName "Tier $Tier - $Vendor $Name" -GroupCategory Security -GroupScope Global -SamAccountName "Tier $Tier - $Vendor $Name" -Name "Tier $Tier - $Vendor $Name - Devices" -Path 'OU=Dev,OU=Software Distribution Groups,OU=Groups,OU=BCC,DC=ad,DC=bcc,DC=qld,DC=gov,DC=au' -Description 'Windows 10'

    Add-CMDeviceCollectionQueryMembershipRule -Collection $collection -RuleName 'AD Group Membership' -QueryExpression "select SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System WHERE SMS_R_System.SystemGroupName = ""BCC\\Tier 2 - $Vendor $Name - Devices"""

    #Add-CMDeviceCollectionQueryMembershipRule -Collection $uninstallCollection -RuleName 'Software Inventory' -QueryExpression "select SMS_R_USER.ResourceID,SMS_R_USER.ResourceType,SMS_R_USER.Name,SMS_R_USER.UniqueUserName,SMS_R_USER.WindowsNTDomain from SMS_R_User inner join SMS_G_System_AppClientState on SMS_R_USER.UniqueUserName = SMS_G_System_AppClientState.UserName   where SMS_G_System_AppClientState.AppName = ""$ApplicationFullName""   and G_System_AppClientState.ComplianceState = 1"

    Add-CMDeviceCollectionQueryMembershipRule -Collection $uninstallCollection -RuleName 'Software Inventory' -QueryExpression "SMS_R_SYSTEM.ResourceID,SMS_R_SYSTEM.ResourceType,SMS_R_SYSTEM.Name,SMS_R_SYSTEM.SMSUniqueIdentifier,SMS_R_SYSTEM.ResourceDomainORWorkgroup,SMS_R_SYSTEM.Client from SMS_R_System inner join SMS_G_System_AppClientState on SMS_R_System.Name = SMS_G_System_AppClientState.MachineName   where SMS_G_System_AppClientState.AppName = ""$ApplicationFullName""   and G_System_AppClientState.ComplianceState = 1"

    Add-CMDeviceCollectionExcludeMembershipRule -Collection $uninstallCollection -ExcludeCollection $collection
}
