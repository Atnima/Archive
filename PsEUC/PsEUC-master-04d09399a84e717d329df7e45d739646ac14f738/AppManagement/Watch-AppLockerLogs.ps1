
function Watch-AppLockerLogs
{
    [CmdletBinding()]
    Param
    (
    )

    while ($true)
    {
        Get-AppLockerLogs -Minutes 1
        Start-Sleep -Seconds 60
    }
}
