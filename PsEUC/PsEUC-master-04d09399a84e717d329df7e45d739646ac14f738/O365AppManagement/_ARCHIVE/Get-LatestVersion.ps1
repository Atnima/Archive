function Get-LatestVersion
{
    [CmdletBinding()]
    param
    (
        [string]$Path
    )

    process
    {
        [System.Version]$latestVersion = '1.0.0.0'
        $versions = Get-ChildItem -Path "$Path" -Directory
        foreach ($version in $Versions)
        {
            try
            {
                if ([System.Version]$version.Name -gt $latestVersion)
                {
                    $latestVersion = [System.Version]$version.Name
                }
            }
            catch
            {
            }
        }

        Write-Output $($latestVersion.ToString())
    }
}
