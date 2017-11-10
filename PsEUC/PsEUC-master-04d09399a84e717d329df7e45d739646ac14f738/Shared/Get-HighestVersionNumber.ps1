function Get-HighestVersionNumber
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        $Versions,
        [switch]$SecondHighest

    )

    $latestVersion = [System.Version]'0.0.0.0'
    $secondLatestVersion = [System.Version]'0.0.0.0'

    foreach ($item in $Versions)
    {
        try
        {
            $parsedVersion = [System.Version]$item
            if ($parsedVersion -gt $latestVersion)
            {
                $secondLatestVersion = $latestVersion
                $latestVersion = $parsedVersion
            }
        }
        catch {}
    }

    if ($SecondHighest)
    {
        Write-Output $secondLatestVersion
    }
    else
    {
        Write-Output $latestVersion
    }
}

