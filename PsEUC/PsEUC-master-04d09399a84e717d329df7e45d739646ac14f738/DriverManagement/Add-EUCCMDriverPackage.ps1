
function Add-EUCCMDriverPackage
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$Vendor,
        [Parameter(Mandatory=$true)]
        [string]$Version,
        [Parameter(Mandatory=$true)]
        [string]$Path,
        [Parameter(Mandatory=$true)]
        [string]$FileName,
        [Parameter(Mandatory=$true)]
        $Model,
        [Parameter(Mandatory=$true)]
        [ValidateSet('Windows-10', 'Windows-81', 'Windows-7')]
        $OperatingSystem,
        [Parameter(Mandatory=$true)]
        [ValidateSet('x86', 'x64')]
        $Architecture
    )

    [string]$packageName = "$Vendor $Model Driver Pack $OperatingSystem $Architecture $Version"

    New-CMPackage -Name "$packageName" -Manufacturer "$Vendor" -Version "$Version" -Path "$Path"
    New-CMProgram -CommandLine "$FileName /verysilent" -PackageName "$packageName" -StandardProgramName 'Install driver pack' -RunType Hidden -ProgramRunType WhetherOrNotUserIsLoggedOn -RunMode RunWithAdministrativeRights
    Set-CMProgram -PackageName "$packageName" -AfterRunningType ConfigurationManagerRestartsComputer -ProgramName 'Install driver pack' -StandardProgram -UserInteraction $false
    Start-CMContentDistribution -PackageName "$packageName" -DistributionPointName 'm562prd1.ad.bcc.qld.gov.au'

}

#Add-EUCCMDriverPackage -Vendor Microsoft -Model 'Surface 3' -Version '2015-11-09' -Path '\\m562prd1\src$\CM_Managed\Drivers\ConfigMgr\Microsoft.Surface-3.Windows-10.x64.2015-11-09' -FileName 'Microsoft.Surface-3.Windows-10.x64.2015-11-09.exe' -OperatingSystem Windows-10 -Architecture x64
#Add-EUCCMDriverPackage -Vendor Microsoft -Model 'Surface 3' -Version '2015-11-09' -Path '\\m562prd1\src$\CM_Managed\Drivers\ConfigMgr\Microsoft.Surface-3.Windows-81.x64.2015-11-09' -FileName 'Microsoft.Surface-3.Windows-81.x64.2015-11-09.exe' -OperatingSystem Windows-81 -Architecture x64

#Add-EUCCMDriverPackage -Vendor Microsoft -Model 'Surface Pro 3' -Version '2015-10-26' -Path '\\m562prd1\src$\CM_Managed\Drivers\ConfigMgr\Microsoft.Surface-Pro-3.Windows-10.x64.2015-10-26' -FileName 'Microsoft.Surface-Pro-3.Windows-10.x64.2015-10-26.exe' -OperatingSystem Windows-10 -Architecture x64
#Add-EUCCMDriverPackage -Vendor Microsoft -Model 'Surface Pro 3' -Version '2015-10-26' -Path '\\m562prd1\src$\CM_Managed\Drivers\ConfigMgr\Microsoft.Surface-Pro-3.Windows-81.x64.2015-10-26' -FileName 'Microsoft.Surface-Pro-3.Windows-81.x64.2015-10-26.exe' -OperatingSystem Windows-81 -Architecture x64

#Add-EUCCMDriverPackage -Vendor Microsoft -Model 'Surface Pro 4' -Version '2015-12-03' -Path '\\m562prd1\src$\CM_Managed\Drivers\ConfigMgr\Microsoft.Surface-Pro-4.Windows-10.x64.2015-12-03' -FileName 'Microsoft.Surface-Pro-4.Windows-10.x64.2015-12-03.exe' -OperatingSystem Windows-10 -Architecture x64
