function New-EUCCMWebShortcut
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$WebAppName,
        [Parameter(Mandatory=$true)]
        [string]$SiteUrl,
        [ValidateSet('Chrome', 'ChromeApp', 'IE')]
        [Parameter(Mandatory=$true)]
        [string]$Browser
    )

    # TODO : check for wix and ahk
    $WIX_PATH = 'C:\Program Files (x86)\WiX Toolset v3.10'
    $AHK_PATH = 'C:\Program Files\AutoHotkey'
    $SRC_FOLDER = '\\m562prd1\src$\CM_Managed\Apps\Tier2'
    $DEPLOYMENT_COLLECTION = 'All Users'

    $uniqueString = ([char[]]([char]'a'..[char]'z') + 0..9 | sort { Get-Random })[0..12] -join ''
    $tempPath = (New-Item "$env:TEMP" -Name $uniqueString -ItemType Directory).FullName
    $webAppNameCode = $WebAppName.Replace(' ', '').Replace('.', '').Replace('(', '').Replace(')', '')

    Write-Verbose "Temp path is '$tempPath'"
    Write-Verbose "Short app name is '$webAppNameCode'"


    switch ($Browser)
    {
        'IE' {
            $ahkCustom = "Run, c:\Program Files (x86)\Internet Explorer\iexplore.exe -noframemerging $SiteUrl"
            $wixCustom =  "<Icon Id=""ico_$webAppNameCode"" SourceFile=""c:\Program Files (x86)\Internet Explorer\iexplore.exe"" />"
            $icon = '\\m562prd1\icons$\internet-explorer.ico'    
        }
        'Chrome' {
            $ahkCustom = "Run, c:\Program Files (x86)\Google\Chrome\Application\chrome.exe $SiteUrl"
            $wixCustom =  "<Icon Id=""ico_$webAppNameCode"" SourceFile=""c:\Program Files (x86)\Google\Chrome\Application\chrome.exe"" />"
            $icon = '\\m562prd1\icons$\chrome2.ico'
        }
        'ChromeApp' {
            $ahkCustom = "Run, c:\Program Files (x86)\Google\Chrome\Application\chrome.exe --ignore-certificate-errors --app=$SiteUrl"
            $wixCustom =  "<Icon Id=""ico_$webAppNameCode"" SourceFile=""c:\Program Files (x86)\Google\Chrome\Application\chrome.exe"" />"
            $icon = '\\m562prd1\icons$\chrome2.ico'
        }
    }

    # build exe
    $ahk = @"
#NoEnv
#Warn
#NoTrayIcon
SendMode Input
SetWorkingDir %A_ScriptDir%

$ahkCustom
"@

    Set-Content -Value $ahk -Path "$tempPath\$webAppNameCode.ahk"
    Start-Process -FilePath "$AHK_PATH\Compiler\Ahk2Exe.exe" -ArgumentList "/in ""$tempPath\$webAppNameCode.ahk"" /out ""$tempPath\$webAppNameCode.exe"" /bin ""$AHK_PATH\Compiler\Unicode 64-bit.bin""" -NoNewWindow -Wait

    # build msi
    $wix = @"
<?xml version="1.0"?>
<Wix xmlns="http://schemas.microsoft.com/wix/2006/wi">
    <Product Id="*" Name="Shortcut for $WebAppName" Language="1033" Version="1.0.0.0" Manufacturer="Brisbane City Council" UpgradeCode="{$(New-Guid)}">
        <Package Description="Assets for MOEvNext" Manufacturer="Brisbane City Council" InstallerVersion="200" Compressed="yes" Platform="x64" />
        <MajorUpgrade DowngradeErrorMessage="A later version of [ProductName] is already installed. Setup will now exit." />
        <Media Id="1" Cabinet="product.cab" EmbedCab="yes" />
        <Property Id="ALLUSERS" Value="1" />
        <Directory Id="TARGETDIR" Name="SourceDir">
            <Directory Id="ProgramMenuFolder" Name="ProgramMenuFolder">
                <Directory Id="OnlineSystems" Name="Online Systems">
                </Directory>    
            </Directory>
            <Directory Id="ProgramFiles64Folder" Name="ProgramFiles64Folder">
                <Directory Id="dir_bcc" Name="BCC">
                    <Directory Id="dir_shortcuts" Name="Shortcuts">
                        <Component Id="cmp_$webAppNameCode" Guid="*" Win64="yes">
                            <File Id="fil_$webAppNameCode" Name="$webAppNameCode.exe" DiskId="1" Source="$tempPath\$webAppNameCode.exe">
                                <Shortcut Id="sht_$webAppNameCode" Directory="OnlineSystems" Name="$WebAppName" WorkingDirectory="INSTALLFOLDER" Icon="ico_$webAppNameCode" IconIndex="0">
                                    $wixCustom
                                    <ShortcutProperty Key="System.AppUserModel.ID" Value="BCC.MOEvNext.Shortcut.$webAppNameCode" />
                                </Shortcut>
                            </File>
                        </Component>
                    </Directory>
                </Directory>
            </Directory>
        </Directory>
        <DirectoryRef Id="TARGETDIR">
        </DirectoryRef>
        <Feature Id="MainFeature" Title="Shortcut" Level="1">
            <ComponentRef Id="cmp_$webAppNameCode" />
        </Feature>
    </Product>
</Wix>
"@

    Set-Content -Value $wix -Path "$tempPath\$webAppNameCode.wix"
    Start-Process -FilePath "$WIX_PATH\bin\candle.exe" -ArgumentList """$tempPath\$webAppNameCode.wix"" -o ""$tempPath\$webAppNameCode.wixobj""" -NoNewWindow -Wait
    Start-Process -FilePath "$WIX_PATH\bin\light.exe" -ArgumentList """$tempPath\$webAppNameCode.wixobj"" -o ""$tempPath\$webAppNameCode.msi""" -NoNewWindow -Wait

    # copy to source folder
    New-Item -Path "$SRC_FOLDER" -Name "BCCWebShortcutFor$($webAppNameCode)_1.0.0.0" -ItemType Directory > $null
    New-Item -Path "$SRC_FOLDER\BCCWebShortcutFor$($webAppNameCode)_1.0.0.0" -Name 'Development' -ItemType Directory > $null
    New-Item -Path "$SRC_FOLDER\BCCWebShortcutFor$($webAppNameCode)_1.0.0.0" -Name 'Distribution' -ItemType Directory > $null
    New-Item -Path "$SRC_FOLDER\BCCWebShortcutFor$($webAppNameCode)_1.0.0.0\Distribution" -Name 'x86' -ItemType Directory > $null
    New-Item -Path "$SRC_FOLDER\BCCWebShortcutFor$($webAppNameCode)_1.0.0.0\Distribution\x86" -Name 'REV01' -ItemType Directory > $null
    New-Item -Path "$SRC_FOLDER\BCCWebShortcutFor$($webAppNameCode)_1.0.0.0\Distribution" -Name 'x64' -ItemType Directory > $null
    New-Item -Path "$SRC_FOLDER\BCCWebShortcutFor$($webAppNameCode)_1.0.0.0\Distribution\x64" -Name 'REV01' -ItemType Directory > $null
    New-Item -Path "$SRC_FOLDER\BCCWebShortcutFor$($webAppNameCode)_1.0.0.0" -Name 'Documentation' -ItemType Directory > $null
    New-Item -Path "$SRC_FOLDER\BCCWebShortcutFor$($webAppNameCode)_1.0.0.0" -Name 'Source' -ItemType Directory > $null
    New-Item -Path "$SRC_FOLDER\BCCWebShortcutFor$($webAppNameCode)_1.0.0.0\Source" -Name 'x86' -ItemType Directory > $null
    New-Item -Path "$SRC_FOLDER\BCCWebShortcutFor$($webAppNameCode)_1.0.0.0\Source" -Name 'x64' -ItemType Directory > $null

    Copy-Item -Path "$tempPath\$webAppNameCode.wix" -Destination "$SRC_FOLDER\BCCWebShortcutFor$($webAppNameCode)_1.0.0.0\Development" > $null
    Copy-Item -Path "$tempPath\$webAppNameCode.ahk" -Destination "$SRC_FOLDER\BCCWebShortcutFor$($webAppNameCode)_1.0.0.0\Development" > $null
    Copy-Item -Path "$tempPath\$webAppNameCode.exe" -Destination "$SRC_FOLDER\BCCWebShortcutFor$($webAppNameCode)_1.0.0.0\Development" > $null
    Copy-Item -Path "$tempPath\$webAppNameCode.msi" -Destination "$SRC_FOLDER\BCCWebShortcutFor$($webAppNameCode)_1.0.0.0\Distribution\x64\REV01" > $null

    $location = Get-Location
    Set-Location 'ka1:'

    $app = New-CMApplication -Name "BCC Web Shortcut for $WebAppName 1.0.0.0" -Publisher 'BCC' -SoftwareVersion '1.0.0.0' -LocalizedName "$WebAppName" -IconLocationFile "$icon"
    $deployment = Add-CMMsiDeploymentType -ApplicationName "BCC Web Shortcut for $WebAppName 1.0.0.0" -EnableBranchCache -EstimatedRuntimeMins 5 -MaximumRuntimeMins 15 -LogonRequirementType WhereOrNotUserLoggedOn -ContentLocation "$SRC_FOLDER\BCCWebShortcutFor$($webAppNameCode)_1.0.0.0\Distribution\x64\REV01\$webAppNameCode.msi" -Force
    Start-CMContentDistribution -ApplicationName "BCC Web Shortcut for $WebAppName 1.0.0.0" -DistributionPointName 'm562prd1.ad.bcc.qld.gov.au'
    Start-CMApplicationDeployment -CollectionName "$DEPLOYMENT_COLLECTION" -DeployAction Install -DeployPurpose Available -UserNotification DisplaySoftwareCenterOnly -Name "BCC Web Shortcut for $WebAppName 1.0.0.0"

    Set-Location $location
}