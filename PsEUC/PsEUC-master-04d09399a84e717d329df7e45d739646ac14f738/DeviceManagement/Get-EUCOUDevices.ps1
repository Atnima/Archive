function Get-EUCOUDevices {
    [CmdletBinding()]
    param(
        [string]$OU
    )
    
    $devices = @()
    #$computers = @()

    $devices = Get-ADComputer -Filter {(Enabled -eq $true)} -Properties OperatingSystem,lastLogonTimestamp -SearchBase $OU
   
    foreach ($device in $devices) {
        $pcQuery = @"
select *
from SMS_R_System
where SMS_R_SYSTEM.Name = '$($device.Name)'
"@

        $cmRecord = Invoke-CMWmiQuery -Query $pcQuery

        $pcMoreInfoQuery = @"
select *
from SMS_R_System inner join SMS_G_System_COMPUTER_SYSTEM on SMS_G_System_COMPUTER_SYSTEM.ResourceID = SMS_R_System.ResourceId
inner join SMS_G_System_OPERATING_SYSTEM on SMS_G_System_OPERATING_SYSTEM.ResourceID = SMS_R_System.ResourceId
where SMS_R_SYSTEM.Name = '$($device.Name)'
"@

        $cmRecordMoreInfo = Invoke-CMWmiQuery -Query $pcMoreInfoQuery

        $userQuery = @"
select sms_r_user.UserName, SMS_UserMachineRelationship.ResourceName from sms_r_user
inner join SMS_UserMachineRelationship on SMS_UserMachineRelationship.UniqueUserName = sms_r_user.UniqueUserName
where SMS_UserMachineRelationship.ResourceID = '$($cmRecord.ResourceId)'
"@
        
        $cmUserInfo = Invoke-CMWmiQuery -Query $userQuery
        $groups = (Get-ADComputer $($device.Name) -Properties memberOf).MemberOf | ? { $_ -like 'cn=tier 2*' }
        
        $allGroups = $null
        foreach ($group in $groups) {
            $allGroups += "$($group.Replace("",OU=Prod,OU=Software Distribution Groups,OU=Groups,OU=BCC,DC=ad,DC=bcc,DC=qld,DC=gov,DC=au"","""").Replace(""CN=Tier 2 - "","""")),"
        }

        $allUsers = $null
        foreach ($user in $($cmUserInfo.sms_r_user.UserName)) {
            try {
                $userDetails = Get-AdUser $user -Properties DisplayName
            }
            catch {}

            $allUsers += "$($userDetails.DisplayName) - $user,"      
        }

        if ($allGroups) { $allGroups = $allGroups.TrimEnd(",") }
        if ($allUsers) { $allUsers = $allUsers.TrimEnd(",") }

        # we know "O_E_M_C_" devices are actually Surface Pro 3 devices with an old firmware
        $hardwareModel = $cmRecordMoreInfo.SMS_G_System_COMPUTER_SYSTEM.Model
        if ($hardwareModel -like 'O_E_M_C_') { $hardwareModel = 'Surface Pro 3' }

        Write-Output $(New-Object PSCustomObject -Property @{
            Name = $($device.Name)
            AdOperatingSystem = $($device.OperatingSystem)
            AdEnabled = $($device.Enabled)
            AdOu = $($device.DistinguishedName).TrimStart("CN=$($device.Name),")
            AdLastLogonTimestamp = [datetime]::FromFileTime($($device.lastLogonTimestamp))
            CcmActive = $cmRecord.Active
            CcmClient = $cmRecord.Client
            CcmModel = $hardwareModel
            CcmOsVersion = $cmRecordMoreInfo.SMS_G_System_OPERATING_SYSTEM.Version
            CcmPrimaryUser = $allUsers
            AdGroupMembership = $allGroups
        })
    }
}
