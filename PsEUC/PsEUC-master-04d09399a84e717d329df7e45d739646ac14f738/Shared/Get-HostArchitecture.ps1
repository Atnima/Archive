<#
.SYNOPSIS
    Return the type of architecture the current host is running in
#>
function Get-HostArchitecture
{
    [CmdletBinding()]
    [OutputType([string])]
    param ()

	if ($([IntPtr]::size -eq 4))
	{
		Write-Output 'x86'
	}
	else
	{
		Write-Output 'x64'
	}
}
