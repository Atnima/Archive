function Get-CMResourceByUuid
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        $Param1,

        # Param2 help description
        [int]
        $Param2
    )

Invoke-CMWmiQuery -Query "select * from sms_r_system where SMBIOSGUID like 'd7d2f385%'"
}