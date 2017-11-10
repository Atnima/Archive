function Get-CleanString
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true)]
        [string]$Value
    )

    $Value = $Value.Replace(' ', '')
    $Value = $Value.Replace('Corporation', '')
    $Value = $Value.Replace('-', '')
    $Value = $Value.Replace('.', '')
    $Value = $Value.Replace('_', '')
    $Value = $Value.Replace('(', '')
    $Value = $Value.Replace(')', '')

    Write-Output $Value

}
