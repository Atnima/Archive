
function New-EUCO365Application
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$O365SoftLibPath
    )

    $version = Get-EUCO365VersionFromSource -Source "$O365SoftLibPath\Distribution\CURRENT\Office\Data"

    $currentLocation = Get-Location
    Set-Location KA1:

    #New-CMApplication -Name "Microsoft Office 365 Pro Plus $($version.ToString())" -Publisher Microsoft -SoftwareVersion "$($version.ToString())" -LocalizedApplicationName 'Office 365 Pro Plus'
    #Move-CMObject -FolderPath 'KA1:\Application\MOEvNext\Production' -InputObject $(Get-CMApplication -Name "Microsoft Office 365 Pro Plus $($version.ToString())")

Add-xCMDeploymentTypeScriptInstaller -ApplicationName "Microsoft Office 365 Pro Plus 15.0.4745.1001" -DeploymentName "Install Office 365 Pro Plus" -PowershellDetectionScript "ladeda" -InstallCommand '"c:\Program Files\Microsoft Office 15\ClientX64\officec2rclient.exe" /update user forceappshutdown=false displaylevel=true updatetoversion=15.0.4745.1001' -UserInteractMode Normal -ExecutionContext User -PostInstallBehaviour NoAction -ComputerName m562prd1.ad.bcc.qld.gov.au -MaximumExecutionTimeInMinutes 30 -EstimatedExecutionTimeInMinutes 15 


Add-xCMApplicationSupersedence -ApplicationName "Microsoft Office 365 Pro Plus 15.0.4745.1001" -SupersededApplicationName "Microsoft Office 365 Pro Plus 15.0.4737.1003" -ComputerName m562prd1.ad.bcc.qld.gov.au 

Add-xCMDeploymentTypeRequirement -ApplicationName "Microsoft Office 365 Pro Plus 15.0.4745.1001" -AuthoringScopeId "ScopeId_480B40CE-C6FF-4CEA-A02D-13037CE8AEE2" -LogicalName "GlobalSettings_f7ee8bcc-a199-465e-9c55-5cab30ccde00" -SettingLogicalName "RegSetting_599724bb-8714-49e8-9411-0d376a741c14" -ValueDataType Version -Expression LessEquals -ComputerName m562prd1.ad.bcc.qld.gov.au -Value '15.0.4745.1001'

Add-xCMDeploymentTypeRequirement -ApplicationName "Microsoft Office 365 Pro Plus 15.0.4745.1001" -OperatingSystem Windows81x64 -ComputerName m562prd1.ad.bcc.qld.gov.au

Add-xCMDeploymentTypeRequirement -ApplicationName "Microsoft Office 365 Pro Plus 15.0.4745.1001" -OperatingSystem Windows10x64 -ComputerName m562prd1.ad.bcc.qld.gov.au




<#



# create deployment type

    install command : c:\Program Files\Microsoft Office 15\ClientX64\officec2rclient.exe" /update user forceappshutdown=false displaylevel=true updatetoversion=15.0.4737.1003
    detect rule : 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\O365ProPlusRetail - en-us' DisplayVersion as string, contains "$version"
    install for user
    requirements : o365-2 value is less than or equal to $version
    create supersedence


# push content to DP
#>

    Set-Location $currentLocation
}