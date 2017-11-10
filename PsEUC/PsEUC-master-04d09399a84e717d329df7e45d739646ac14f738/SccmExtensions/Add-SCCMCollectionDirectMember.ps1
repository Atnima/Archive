function Add-SCCMCollectionDirectMember {
    [CmdletBinding()]
    param(
        [string]$CollectionId,
        [string]$ComputerName,
        [string]$Server = 'm354prd1',
        [string]$Site = 'B01'
    )

    $devices = Get-WmiObject -ComputerName $Server -Namespace "root\SMS\Site_$Site" -Query "select ResourceId from SMS_R_SYSTEM where Name = '$ComputerName'"

    if ($devices) {
        foreach ($device in $devices) {
            $wmiCollection =  [wmi]"\\$Server\root\sms\site_$($Site):SMS_Collection.CollectionID='$CollectionId'" 
            $wmiCollectionRule = [WmiClass]"\\$Server\root\sms\site_$($Site):SMS_CollectionRuleDirect"  
            $wmiCollectionRule.Properties["ResourceClassName"].value = "SMS_R_System"  
            $wmiCollectionRule.Properties["ResourceID"].value = $($device.ResourceId)

            $wmiParameters = $wmiCollection.GetMethodParameters('AddMembershipRule')
            $wmiParameters.CollectionRule = $wmiCollectionRule
            $result = $wmiCollection.InvokeMethod('AddMembershipRule', $wmiParameters, $null)

            if ($($result.ReturnValue) -eq 0) {
                Write-Output $true
            }
            else {
                Write-Output $false
            }
        }
    }
    else {
        Write-Warning "No device record found for $ComputerName"
    }
}  
