
function Update-EUCDeploymentShare
{
    <#
    .Synopsis
       Updates an MDT deployment share
    .DESCRIPTION
       Copies across custom files (for example scripts) and synchronises the production MDT share with development
    .EXAMPLE
       Update-EUCDeploymentShare -From H:\repos\MOEvNextOSD -Destination Development
    #>

    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$ReposPath,
        [Parameter(Mandatory = $true)]
        [ValidateSet('Prod', 'Development')]
        [System.String]$Destination
    )

    Begin
    {
        #$mdtDestinationPath = $((Get-EUCSettings).MDTDevShare)
        #if ($Destination -eq 'Prod')
        {
            # TODO : Confirm!
            #$mdtDestinationPath = $((Get-PsEUCSettings).MDTProdShare)
        }

        #Import-Module 'C:\Program Files\Microsoft Deployment Toolkit\Bin\MicrosoftDeploymentToolkit.psd1'
        
    }
    Process
    {

        $BCCMOEVNEXTOSDPATH = '\\m370prd1\PkgDev\Packages\BCCMOEvNextOSD\Development'


        # update custom
        if (!(Test-Path "$mdtDestinationPath\custom")) { New-Item "$mdtDestinationPath\custom" -ItemType Directory }
        if (!(Test-Path "$mdtDestinationPath\custom\x64")) { New-Item "$mdtDestinationPath\custom\x64" -ItemType Directory }
        Copy-Item -Path "$From\mdt\custom\background.bmp" "$mdtDestinationPath\custom" -Force
        Copy-Item -Path "$From\mdt\custom\x64\unattend.xml" "$mdtDestinationPath\custom\x64" -Force
        Copy-Item -Path "$From\hwconfig\bootstrap.ps1" "$mdtDestinationPath\custom\x64" -Force

        # update hwconfig
        if (!(Test-Path "$mdtDestinationPath\hwconfig")) { New-Item "$mdtDestinationPath\hwconfig" -ItemType Directory }
        Copy-Item -Path "$From\hwconfig\enablebde.ps1" "$mdtDestinationPath\Scripts" -Force
        Copy-Item -Path "$From\hwconfig\initbde.ps1" "$mdtDestinationPath\Scripts" -Force
        Copy-Item -Path "$From\hwconfig\hwconfig.ps1" "$mdtDestinationPath\hwconfig" -Force
        Copy-Item -Path "$From\hwconfig\hwconfig_modules.psm1" "$mdtDestinationPath\hwconfig" -Force
        Copy-Item -Path "$From\hwconfig\assets.csv" "$mdtDestinationPath\hwconfig" -Force
        Copy-Item -Path "$From\hwconfig\cleardisk.dsp" "$mdtDestinationPath\hwconfig" -Force

        # update scripts
        Copy-Item -Path "$From\mdt\scripts\moe81postbuild.ps1" "$mdtDestinationPath\scripts" -Force
		Copy-Item -Path "$From\mdt\scripts\ward81postbuild.ps1" "$mdtDestinationPath\scripts" -Force
        Copy-Item -Path "$From\mdt\scripts\ward81deployfinalise.ps1" "$mdtDestinationPath\scripts" -Force
		Copy-Item -Path "$From\mdt\scripts\ward7postbuild.ps1" "$mdtDestinationPath\scripts" -Force
        Copy-Item -Path "$From\mdt\scripts\PsOsdHelpers.dll" "$mdtDestinationPath\scripts" -Force
        Copy-Item -Path "$From\mdt\scripts\mappackagedrive.ps1" "$mdtDestinationPath\scripts" -Force
        Copy-Item -Path "$From\mdt\scripts\Action-CleanupBeforeSysprep.wsf" "$mdtDestinationPath\scripts" -Force

        # ensure logs folder exists
        if (!(Test-Path "$mdtDestinationPath\logs")) { New-Item "$mdtDestinationPath\logs" -ItemType Directory }

        if ($Destination -eq 'Prod')
        {
            # sync drivers
            # sync applications
            # sync selection profiles
        }
    }
    End
    {
    }
}
