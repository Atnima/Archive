function Publish-EUCCMTier3MsiApplication
{
    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='High')]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true)]
        [string]$Msi,
        [string]$Vendor,
        [string]$Name,
        [string]$Version
    )

    $TIER_3_PATH = '\\m562prd1\src$\CM_Managed\Apps\Tier3'

    $currentLocation = Get-Location

    $msiFile = Get-Item $Msi
    $msiDetails = Get-MsiTable -Table 'Property' -Path "$($msiFile.FullName)"

    if (-Not $Vendor) {
        $Vendor = $($msiDetails | ? { $_.Property -eq 'Manufacturer' }).Value
    }

    if (-Not $Name) {
        $Name = $($msiDetails | ? { $_.Property -eq 'ProductName' }).Value
    }

    if (-Not $Version) {
        $Version = $($msiDetails | ? { $_.Property -eq 'ProductVersion' }).Value
    }

    #$Vendor = $(Get-CleanString -Value $Vendor)
    #$Name = $(Get-CleanString -Value $Name)

    $fullAppName = "$(Get-CleanString -Value $Vendor) $($Name) $Version"
    $appName = "$(Get-CleanString -Value $Vendor)$(Get-CleanString -Value $Name)_$Version"

    Write-Verbose "Vendor : $Vendor"
    Write-Verbose "Name : $Name"
    Write-Verbose "Version : $Version"
    Write-Verbose "Application Name : $fullAppName"
    Write-Verbose "Abbreviated Name : $appName"

    if ($pscmdlet.ShouldProcess("$msiFile", "Publish tier 3 application to ConfigMgr called $appName")) {
        New-EUCAppPackageFolder -Path "$TIER_3_PATH" -Name "$appName"
        Copy-Item -Path "$msiFile" -Destination "$TIER_3_PATH\$appName\Distribution\x64\REV01"

        Set-Location KA1:
        New-CMApplication -Name "$fullAppName" -Publisher "$Vendor" -SoftwareVersion "$Version" -LocalizedName "$Name"
        Add-CMMsiDeploymentType -ApplicationName "$fullAppName" -LogonRequirementType WhereOrNotUserLoggedOn -ContentLocation "$TIER_3_PATH\$appName\Distribution\x64\REV01\$($msiFile.Name)"
        Start-CMContentDistribution -ApplicationName "$fullAppName" -DistributionPointName 'm562prd1.ad.bcc.qld.gov.au'
        Start-CMApplicationDeployment -Name "$fullAppName" -CollectionName 'All Users' -DeployAction Install -DeployPurpose Available -UserNotification DisplaySoftwareCenterOnly
        Set-Location $currentLocation
    }
}
