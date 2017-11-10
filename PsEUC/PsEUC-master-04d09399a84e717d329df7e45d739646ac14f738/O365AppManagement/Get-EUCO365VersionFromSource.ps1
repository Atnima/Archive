function Get-EUCO365VersionFromSource
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$Path
    )

    Write-Output $(Get-HighestVersionNumber -Versions $(Get-ChildItem -Path "$Path" -Directory | select Name | Out-String -Stream))
}
