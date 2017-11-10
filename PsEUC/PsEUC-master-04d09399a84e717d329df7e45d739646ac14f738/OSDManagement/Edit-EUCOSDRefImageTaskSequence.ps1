
function Edit-EUCOSDRefImageTaskSequence
{
    [CmdletBinding()]
    param
    (
        [Parameter(Position = 0, Mandatory = $true)]
        [ValidateSet('Windows7', 'Windows81')]
        [System.String]$OS,
        [Parameter(Position = 1, Mandatory = $true)]
        [ValidateSet('Minor', 'SecurityPatch')]
        [System.String]$ChangeType
    )

    process
    {
        # update local repos
        RefreshOSDRefImageLocalRepos -OS $OS

        if ($ChangeType -eq "SecurityPatch")
        {
            $newVersion = IncrementVersion -Version $(Get-Content .\version.txt) -Increment Patch -Metadata "refimage"
            Set-Content .\version.txt "$($newVersion.Major).$($newVersion.Minor).$($newVersion.Patch)+$($newVersion.Metadata)"

            # publish new version
            # Publish-EUCOSDRefImageTaskSequence
        }

        if ($ChangeType -eq "Minor")
        {
            $newVersion = IncrementVersion -Version $(Get-Content .\version.txt) -Increment Minor -Metadata "refimage"
            Set-Content .\version.txt "$($newVersion.Major).$($newVersion.Minor).$($newVersion.Patch)+$($newVersion.Metadata)"
        }

        Import-MDTTaskSequence -Path 'ds001:\Task Sequences\OSD\Reference Images' -Template '\\m370prd1\DeploymentShare$\Templates\2.3.0+refimage.2014-11-10.xml' -Name 'MOE - Windows 8.1 Ref Image Capture 2.4.0' -ID kj768hgv -Version '2.4.0+refimage.2014-12-08'
           
    }
}
