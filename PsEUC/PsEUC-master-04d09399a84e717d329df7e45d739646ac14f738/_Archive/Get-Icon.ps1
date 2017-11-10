<#
function Get-Icon
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true, Position=0)]
        [string]$File,
        [Parameter(Mandatory=$true, Position=1)]
        [string]$OutputPath
    )

	[System.Reflection.Assembly]::LoadWithPartialName('System.Drawing')  | Out-Null

    try
    {
        [System.Drawing.Icon]::ExtractAssociatedIcon("$File").ToBitmap().Save("$OutputPath\$((Get-Item $File).BaseName).ico")    
    }
    catch
    {
        Write-Warning -Message 'An exception was called attempting to extract the icon. Ensure the file is not located on a network share'
        Write-Error $_
    }    
}
#>