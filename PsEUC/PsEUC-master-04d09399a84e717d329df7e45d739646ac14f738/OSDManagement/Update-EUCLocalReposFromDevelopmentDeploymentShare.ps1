
function Update-EUCLocalReposFromDevelopmentDeploymentShare
{
    [CmdletBinding(ConfirmImpact = ’High’, SupportsShouldProcess = $true)]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$To
    )

    Begin
    {
        $mdtDestinationPath = $((Get-EUCSettings).MDTDevShare)
    }
    Process
    {
        If ($PSCmdlet.ShouldProcess('Files from the development MDT file share will be copied to your local repos, and overwrite any existing files', 'If you continue to run this script, files from the development MDT file share will be copied to your local repos, and overwrite any existing files', 'About to overwrite local files')) {
            Copy-Item -Path "$mdtDestinationPath\Control\MOE7SRCIMAGE\ts.xml" "$To\mdt\Control\MOE7SRCIMAGE"  -Force
            Copy-Item -Path "$mdtDestinationPath\Control\MOE7SRCIMAGE\unattend.xml" "$To\mdt\Control\MOE7SRCIMAGE"  -Force
            Copy-Item -Path "$mdtDestinationPath\Control\MOE81REFIMAGE\ts.xml" "$To\mdt\Control\MOE81REFIMAGE"  -Force
            Copy-Item -Path "$mdtDestinationPath\Control\MOE81REFIMAGE\unattend.xml" "$To\mdt\Control\MOE81REFIMAGE"  -Force
            Copy-Item -Path "$mdtDestinationPath\Control\MOE81SRCIMAGE\ts.xml" "$To\mdt\Control\MOE81SRCIMAGE"  -Force
            Copy-Item -Path "$mdtDestinationPath\Control\MOE81SRCIMAGE\unattend.xml" "$To\mdt\Control\MOE81SRCIMAGE"  -Force
            Copy-Item -Path "$mdtDestinationPath\Control\WARD7REFIMAGE\ts.xml" "$To\mdt\Control\WARD7REFIMAGE"  -Force
            Copy-Item -Path "$mdtDestinationPath\Control\WARD7REFIMAGE\unattend.xml" "$To\mdt\Control\WARD7REFIMAGE"  -Force
            Copy-Item -Path "$mdtDestinationPath\Control\MOE81OSDTS\ts.xml" "$To\mdt\Control\MOE81OSDTS"  -Force
            Copy-Item -Path "$mdtDestinationPath\Control\MOE81OSDTS\unattend.xml" "$To\mdt\Control\MOE81OSDTS"  -Force
            Copy-Item -Path "$mdtDestinationPath\Control\WARD7OSDTS\ts.xml" "$To\mdt\Control\WARD7OSDTS"  -Force
            Copy-Item -Path "$mdtDestinationPath\Control\WARD7OSDTS\unattend.xml" "$To\mdt\Control\WARD7OSDTS"  -Force
            Copy-Item -Path "$mdtDestinationPath\Control\WARD81OSDTS\ts.xml" "$To\mdt\Control\WARD81OSDTS"  -Force
            Copy-Item -Path "$mdtDestinationPath\Control\WARD81OSDTS\unattend.xml" "$To\mdt\Control\WARD81OSDTS"  -Force
            Copy-Item -Path "$mdtDestinationPath\Control\WIN7SP1NOPATCH\ts.xml" "$To\mdt\Control\WIN7SP1NOPATCH"  -Force
            Copy-Item -Path "$mdtDestinationPath\Control\WIN7SP1NOPATCH\unattend.xml" "$To\mdt\Control\WIN7SP1NOPATCH"  -Force
            Copy-Item -Path "$mdtDestinationPath\Control\WIN81NOPATCH\ts.xml" "$To\mdt\Control\WIN81NOPATCH"  -Force
            Copy-Item -Path "$mdtDestinationPath\Control\WIN81NOPATCH\unattend.xml" "$To\mdt\Control\WIN81NOPATCH"  -Force
            Copy-Item -Path "$mdtDestinationPath\Control\CustomSettings.ini" "$To\mdt\Control"  -Force
            Copy-Item -Path "$mdtDestinationPath\Control\Bootstrap.ini" "$To\mdt\Control"  -Force
        }
    }
    End
    {
    }
}
