function New-EUCCMApplication
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, ParameterSetName = 'MsiApplicationParamSet')]
        [Parameter(Mandatory=$true, ParameterSetName = 'ExeApplicationParamSet')]
        [string]$Vendor,
        [Parameter(Mandatory=$true, ParameterSetName = 'MsiApplicationParamSet')]
        [Parameter(Mandatory=$true, ParameterSetName = 'ExeApplicationParamSet')]
        [string]$Name,
        [Parameter(Mandatory=$true, ParameterSetName = 'MsiApplicationParamSet')]
        [Parameter(Mandatory=$true, ParameterSetName = 'ExeApplicationParamSet')]
        [string]$Version,
        [Parameter(Mandatory=$true, ParameterSetName = 'MsiApplicationParamSet')]
        [Parameter(Mandatory=$true, ParameterSetName = 'ExeApplicationParamSet')]
        [string]$Path,
        [Parameter(Mandatory=$true, ParameterSetName = 'MsiApplicationParamSet')]
        [Parameter(Mandatory=$true, ParameterSetName = 'ExeApplicationParamSet')]
        [string]$InstallCommand,
        [Parameter(Mandatory=$true, ParameterSetName = 'ExeApplicationParamSet')]
        [string]$UninstallCommand,
        [Parameter(Mandatory=$true, ParameterSetName = 'ExeApplicationParamSet')]
        [string]$FileToDetect,
        [Parameter(Mandatory=$true, ParameterSetName = 'ExeApplicationParamSet')]
        [string]$FileToDetectVersionExpected,
        [Parameter(ParameterSetName = 'MsiApplicationParamSet')]
        [Parameter(ParameterSetName = 'ExeApplicationParamSet')]
        [string]$IconFile = '',
        [Parameter(ParameterSetName = 'MsiApplicationParamSet')]
        [Parameter(ParameterSetName = 'ExeApplicationParamSet')]
        [switch]$DeployToUser
    )

    $CM_DP = 'm562prd1.ad.bcc.qld.gov.au'

    $appName = Get-EUCCMApplicationName -Vendor $Vendor -Name $Name -Version $Version

    $currentLocation = Get-Location
    Set-Location KA1:

    Write-Warning 'TODO : need to check msi exists'

    New-CMApplication -Name "$($appName.LongName)" -LocalizedApplicationName "$Name" -Publisher "$Vendor" -SoftwareVersion "$Version" | Out-Null

    # BUG : release of 5.0.8249.1128 version of ConfigurationManager cmdlets breaks this command
    # Set-CMApplication -Name "$appName" -AppCategories 'Tier 2'
    # Set-CMApplication -ApplicationName "$appName" -AppCategory 'Tier-2' | Out-Null

    if ($IconFile -ne '')
    {
        Set-CMApplication -ApplicationName "$($appName.LongName)" -IconLocationFile $IconFile | Out-Null
    }

    switch ($PsCmdlet.ParameterSetName)
    {
        'ExeApplicationParamSet'
        {
            # exe based installation
            $detectionScript = @'
try
{
    if ($((Get-Item -Path "$FileToDetect").VersionInfo.ProductVersion) -eq "$FileToDetectVersionExpected") { Write-Output $true }
}
catch {}
'@
            $detectionScript = $detectionScript.Replace('$FileToDetect', "$FileToDetect")
            $detectionScript = $detectionScript.Replace('$FileToDetectVersionExpected', "$FileToDetectVersionExpected")

            Add-CMDeploymentType -ApplicationName "$appName" -ScriptInstaller -InstallationProgram "$InstallCommand" -UninstallProgram "$UninstallCommand" -DeploymentTypeName "Install $Name" -ScriptContent "$detectionScript" -ScriptType PowerShell -ContentLocation "$Path" -InstallationBehaviorType InstallForSystem -LogonRequirementType WhereOrNotUserLoggedOn -RequiresUserInteraction $false

        }
        'MsiApplicationParamSet'
        {
            # msi based installation
            #Add-CMDeploymentType -ApplicationName "$appName" -ForceForUnknownPublisher $true -ContentLocation $Path -MsiInstaller -InstallationBehaviorType InstallForSystem

            Add-CMMsiDeploymentType -ApplicationName "$($appName.LongName)" -InstallCommand $InstallCommand -LogonRequirementType WhereOrNotUserLoggedOn -UserInteractionMode Hidden -ContentLocation $Path -ForceForUnknownPublisher | Out-Null
        }
    }
    
    Start-CMContentDistribution -ApplicationName "$($appName.LongName)" -DistributionPointName $CM_DP | Out-Null

    # update dependencies
    Write-Warning 'TODO : update this to look for older version of the apps. Currently it just assumes all versions are older'
    Write-Warning 'TODO : need to check for supersendence that already exists'

    $previousApps = Get-CMApplication -ApplicationName "$($appName.LongNameNoVersion)*"

    foreach ($app in $previousApps) {
      if ($($app.SoftwareVersion) -ne "$Version") {
        Add-CMDeploymentTypeSupersedence -SupersedingDeploymentType $(Get-CMDeploymentType -ApplicationName "$($appName.LongName)") -SupersededDeploymentType $(Get-CMDeploymentType -ApplicationName "$($app.LocalizedDisplayName)") -IsUninstall $true 
      }
    }

    if ($DeployToUser)
    {
        #Start-CMApplicationDeployment -Name "$appName" -AvailableDateTime $(Get-Date) -DeadlineDateTime $((Get-Date).AddMinutes(1)) -CollectionName 'All Users' -DeployAction Install -DeployPurpose Available -UserNotification DisplaySoftwareCenterOnly | Out-Null

        #Start-CMApplicationDeployment -Name "$($appName.LongName)" -CollectionName 'All Users' -DeployAction Install -DeployPurpose Available -UserNotification DisplaySoftwareCenterOnly | Out-Null
    }
    else
    {
        #New-ADGroup -DisplayName 'Tier 2 - Microsoft Project Professional 2013' -GroupCategory Security -GroupScope Global -SamAccountName 'Tier 2 - Microsoft Project Professional 2013' -Name 'Tier 2 - Microsoft Project Professional 2013' -Path 'OU=Dev,OU=Software Distribution Groups,OU=Groups,OU=BCC,DC=ad,DC=bcc,DC=qld,DC=gov,DC=au' -Description 'ConfigMgr 2012 R2'
        #$schedule = New-CMSchedule -DayOfWeek Saturday -RecurCount 1 -Start "30/5/2015 09:01 am"
        #New-CMDeviceCollection -LimitingCollectionId 'SMS00001' -Name 'App Deploy - Microsoft Project Professional 2013' -RefreshType Both -RefreshSchedule $schedule
        #Add-CMDeviceCollectionQueryMembershipRule -CollectionName 'App Deploy - Microsoft Project Professional 2013' -QueryExpression 'SELECT SMS_R_SYSTEM.* FROM SMS_R_System WHERE SMS_R_System.SystemGroupName = "BCC\\Tier 2 - Microsoft Project Professional 2013"' -RuleName 'AD Group Membership'    
    }

    Set-Location $currentLocation
}
