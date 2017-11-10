function UpdatePowerBIDesktopApplication
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [System.IO.DirectoryInfo]$SourcePath,
        [string]$MsiFileName = 'PBIDesktop_x64.msi'
    )

    $packageDetails = Get-MSITable -Table Property -Path "$($SourcePath.FullName)\$MsiFileName"
    #$msiVersion = ($packageDetails | ? { $_.Property -eq 'ProductVersion' }).Value
    #$msiProductCode = ($packageDetails | ? { $_.Property -eq 'ProductCode' }).Value

    #$TIER_2_PATH = '\\m562prd1\src$\CM_Managed\Apps\Tier2'
    #$appName = Get-EUCCMApplicationName -Vendor 'Microsoft' -Name 'PowerBI Desktop' -Version $msiVersion

    #New-EUCAppPackageFolder -Path "$TIER_2_PATH" -Name "$($appName.ShortName)"
    #Copy-Item -Path "$SourcePath\*" -Destination "$TIER_2_PATH\$($appName.ShortName)\Distribution\x64\REV01" -Recurse

    #New-EUCCMApplication -Vendor 'Microsoft' -Name 'PowerBI Desktop' -Version $msiVersion -Path "$TIER_2_PATH\$($appName.ShortName)\Distribution\x64\REV01\PBIDesktop_x64.msi" -IconFile \\m562prd1\icons$\pbidesktop.ico -InstallCommand 'msiexec /i "PBIDesktop_x64.msi" ACCEPT_EULA=1 /qn' -DeployToUser
}
