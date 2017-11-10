<#
.SYNOPSIS
    Test whether the current scripting host process is running elevated
#>
function Test-AdminStatus
{
    [CmdletBinding()]
    [OutputType([bool])]
    param ()

	Write-Output $(([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator'))
}
