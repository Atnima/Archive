<#
.SYNOPSIS
    Get a collection of settings defined in the global.json file based on group name
#>
function Get-EUCSetting
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        $Group
    )

    (ConvertFrom-Json -InputObject (Get-Content "$($PSScriptRoot)\..\Globals.json" -Raw)).($Group)
}
