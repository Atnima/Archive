function Get-MissingPnpDevices
{
    [CmdletBinding()]
    Param
    (
    )

    Process
    {
       Get-WmiObject Win32_PnpEntity | ? { $_.Status -eq 'Error' } 
    }
}
