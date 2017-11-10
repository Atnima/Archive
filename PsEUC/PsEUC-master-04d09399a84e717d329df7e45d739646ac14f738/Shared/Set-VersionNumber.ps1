function Set-VersionNumber
{
    [CmdletBinding()]
    [OutputType([version])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true)]
        [version]$VersionNumber,
        [switch]$IncrementMajor,
        [switch]$IncrementMinor
    )

    if ($($VersionNumber.Revision) -eq -1)
    {
        if ($($VersionNumber.Build) -eq -1)
        {
            $VersionNumber = "$($VersionNumber.Major).$($VersionNumber.Minor).0.0"
        }
        else
        {
            $VersionNumber = "$($VersionNumber.Major).$($VersionNumber.Minor).$($VersionNumber.Build).0"
        }
    }

    if ($IncrementMajor)
    {
        $VersionNumber = "$($VersionNumber.Major + 1).$($VersionNumber.Minor).$($VersionNumber.Build).$($VersionNumber.Revision)"
    }

    if ($IncrementMinor)
    {
        $VersionNumber = "$($VersionNumber.Major).$($VersionNumber.Minor + 1).$($VersionNumber.Build).$($VersionNumber.Revision)"
    }

    Write-Output $VersionNumber
}