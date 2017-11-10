# http://www.moyerteam.com/2012/11/powershell-trigger-configmgr-client-action-scheduleid/

function Start-CMDeviceMachinePolicyRefresh
{
    [CmdletBinding()]
    Param
    (
    )
    
    ([wmiclass]"\\.\root\ccm:sms_client").TriggerSchedule("{00000000-0000-0000-0000-000000000021}")
    Start-Sleep -Seconds 10
    ([wmiclass]"\\.\root\ccm:sms_client").TriggerSchedule("{00000000-0000-0000-0000-000000000022}")
}

function Start-CMDeviceAppDeploymentEvaluation
{
    [CmdletBinding()]
    Param
    (
    )

    ([wmiclass]"\\.\root\ccm:sms_client").TriggerSchedule("{00000000-0000-0000-0000-000000000121}")
}

function Start-CMDeviceSoftwareUpdateCycle
{
    [CmdletBinding()]
    Param
    (
    )

    ([wmiclass]"\\.\root\ccm:sms_client").TriggerSchedule("{00000000-0000-0000-0000-000000000113}")
}

function Start-CMDeviceSoftwareUpdateDeploymentEval
{
    [CmdletBinding()]
    Param
    (
    )

    ([wmiclass]"\\.\root\ccm:sms_client").TriggerSchedule("{00000000-0000-0000-0000-000000000114}")
}


function Start-CMDeviceConfigurationEvaluation
{
    [CmdletBinding()]
    Param
    (
    )

    Get-WmiObject -Namespace 'root/ccm/dcm' -Class SMS_DesiredConfiguration | % { ([wmiclass]"\\.\root\ccm\dcm:SMS_DesiredConfiguration").TriggerEvaluation($_.Name, $_.Version) }
}
