function Update-EUCPowerBIDesktopApplication
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$SourcePath,
        [string]$MsiFileName = 'PBIDesktop_x64.msi'
    )

    $packageDetails = Get-MSITable -Table Property -Path "$SourcePath\$MsiFileName"
    $msiVersion = ($packageDetails | ? { $_.Property -eq 'ProductVersion' }).Value
    $msiProductCode = ($packageDetails | ? { $_.Property -eq 'ProductCode' }).Value

    $TIER_2_PATH = '\\m562prd1\src$\CM_Managed\Apps\Tier2'
    $appName = Get-EUCCMApplicationName -Vendor 'Microsoft' -Name 'PowerBI Desktop' -Version $msiVersion

    New-EUCAppPackageFolder -Path "$TIER_2_PATH" -Name "$($appName.LongName)"
    Copy-Item -Path $SourcePath -Destination "$TIER_2_PATH\$($appName.LongName)\Distribution\x64\REV01"

    New-EUCCMApplication -Vendor 'Microsoft' -Name 'PowerBI Desktop' -Version $msiVersion -Path $SourcePath -IconFile \\m562prd1\icons$\pbidesktop.ico -InstallCommand 'msiexec /i "PBIDesktop_x64.msi" ACCEPT_EULA=1 /qn' -DeployToUser
}


#New-CMApplication -Name "Microsoft PowerBI Desktop $version" -Publisher 'Microsoft' -SoftwareVersion "$version" -LocalizedName 'PowerBI Desktop' -IconLocationFile '\\m562prd1\icons$\pbidesktop.ico'
#Add-CMDeploymentType -MsiInstaller -ContentLocation "$TIER_2_PATH\MicrosoftPowerBIDesktop_$version\Distribution\x64\REV01\PBIDesktop_x64.msi" -ApplicationName "Microsoft PowerBI Desktop $version" -InstallationBehaviorType InstallForSystem -InstallationProgram 'msiexec /i "PBIDesktop_x64.msi" ACCEPT_EULA=1 /qn'
#Add-CMMsiDeploymentType -ApplicationName "Microsoft PowerBI Desktop $version" -InstallCommand 'msiexec /i "PBIDesktop_x64.msi" ACCEPT_EULA=1 /qn' -LogonRequirementType WhereOrNotUserLoggedOn -ContentLocation "$TIER_2_PATH\MicrosoftPowerBIDesktop_$version\Distribution\x64\REV01\PBIDesktop_x64.msi"


#Add-CMDeploymentTypeSupersedence -SupersedingDeploymentType $(Get-CMDeploymentType -ApplicationName "Microsoft PowerBI Desktop $version") -SupersededDeploymentType $(Get-CMDeploymentType -ApplicationName "Microsoft Power BI Desktop 2.34.4372.501") -IsUninstall $true

#Start-CMContentDistribution -ApplicationName "Microsoft PowerBI Desktop $version" -DistributionPointName 'm562prd1.ad.bcc.qld.gov.au'
#Start-CMApplicationDeployment -Name "Microsoft PowerBI Desktop $version" -CollectionName 'All Users' -DeployAction Install -DeployPurpose Available -UserNotification DisplaySoftwareCenterOnly