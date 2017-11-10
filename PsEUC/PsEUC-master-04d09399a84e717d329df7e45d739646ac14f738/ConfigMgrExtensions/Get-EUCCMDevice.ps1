function Get-EUCCMDevice
{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,Position=0)]
        $MacAddress
    )

    Get-WmiObject -ComputerName 'm354prd1' -Namespace 'root\SMS\Site_B01' -query "Select * from SMS_R_SYSTEM where macaddresses like '%$MacAddress%'"# -Credential $credential | select name,LastLogonUserName

}