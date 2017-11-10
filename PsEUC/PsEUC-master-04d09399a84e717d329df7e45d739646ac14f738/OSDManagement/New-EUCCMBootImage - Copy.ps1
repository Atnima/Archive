function New-EUCCMBootImage
{
    [CmdletBinding()]

    Param
    (
    )

    $DISM = 'C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\DISM\dism.exe'
    $WINPE_WORKING_FOLDER = 'C:\temp\winpe'
    $WINPE_PACKAGES = 'C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Windows Preinstallation Environment'

    $env:Path += ';C:\Program Files (x86)\Windows Kits\10\Assessment and Deployment Kit\Deployment Tools\amd64\Oscdimg'

    $startnetContents = @'
@echo off
wpeinit
powershell.exe -noprofile -nologo -executionpolicy bypass -file "%~dp0bootstrap.ps1"
exit
'@

    $tsconfigContents = @'
[CustomHook]
CommandLine=powershell.exe -noprofile -nologo -executionpolicy bypass -file x:\windows\system32\bootstrap.ps1
'@

    $bootstrapContents = @'
<#
    Executed from WinPe before the ConfigMgr wizard starts. Downloads init.ps1 from m562prd1    
#>

function Test-ConfigMgrServerAvailable
{
    trap { return $false }
	$socket = New-Object System.Net.Sockets.TCPClient('m562prd1.ad.bcc.qld.gov.au', '80')
	$socket.Close()
	return $true
}

Write-Host 'Starting bootstrap.ps1'
Write-Host 'Waiting for network to start ' -NoNewline

$networkAvail = $false
do
{
    Start-Sleep -Seconds 1
    Write-Host '.' -NoNewline
}
while (!$(Test-ConfigMgrServerAvailable))
Write-Host '.'

Write-Host 'Running init.ps1'
Invoke-Expression ((New-Object Net.WebClient).DownloadString('http://m562prd1.ad.bcc.qld.gov.au/euc/init.ps1'))
'@

    Copy-Item -Path "$WINPE_PACKAGES\amd64\en-us\winpe.wim" -Destination 'c:\temp'

    $result = Mount-WindowsImage -ImagePath "c:\temp\winpe.wim" -Path "$WINPE_WORKING_FOLDER" -Index 1
    $result = Add-WindowsPackage -PackagePath "$WINPE_PACKAGES\amd64\WinPE_OCs\WinPE-NetFx.cab" -Path "$WINPE_WORKING_FOLDER"
    $result = Add-WindowsPackage -PackagePath "$WINPE_PACKAGES\amd64\WinPE_OCs\en-us\WinPE-NetFx_en-us.cab" -Path "$WINPE_WORKING_FOLDER"
    $result = Add-WindowsPackage -PackagePath "$WINPE_PACKAGES\amd64\WinPE_OCs\WinPE-PowerShell.cab" -Path "$WINPE_WORKING_FOLDER"
    $result = Add-WindowsPackage -PackagePath "$WINPE_PACKAGES\amd64\WinPE_OCs\en-us\WinPE-PowerShell_en-us.cab" -Path "$WINPE_WORKING_FOLDER"
    #$result = Add-WindowsPackage -PackagePath "$WINPE_PACKAGES\amd64\WinPE_OCs\WinPE-DismCmdlets.cab" -Path "$WINPE_WORKING_FOLDER"
    #$result = Add-WindowsPackage -PackagePath "$WINPE_PACKAGES\amd64\WinPE_OCs\en-us\WinPE-DismCmdlets_en-us.cab" -Path "$WINPE_WORKING_FOLDER"
    #$result = Add-WindowsPackage -PackagePath "$WINPE_PACKAGES\amd64\WinPE_OCs\WinPE-SecureBootCmdlets.cab" -Path "$WINPE_WORKING_FOLDER"
    $result = Add-WindowsPackage -PackagePath "$WINPE_PACKAGES\amd64\WinPE_OCs\WinPE-WMI.cab" -Path "$WINPE_WORKING_FOLDER"
    $result = Add-WindowsPackage -PackagePath "$WINPE_PACKAGES\amd64\WinPE_OCs\en-us\WinPE-WMI_en-us.cab" -Path "$WINPE_WORKING_FOLDER"

    #Set-Content "$WINPE_WORKING_FOLDER\Windows\System32\startnet.cmd" -Value $startnetContents
    Set-Content "$WINPE_WORKING_FOLDER\TSConfig.INI" -Value $tsconfigContents
    Set-Content "$WINPE_WORKING_FOLDER\Windows\System32\bootstrap.ps1" -Value $bootstrapContents

    #$result = Add-WindowsDriver -Recurse -Driver '\\m562prd1\src$\CM_Managed\Drivers\Boot-Critical-2' -Path "$WINPE_WORKING_FOLDER"

    # https://support.microsoft.com/en-us/kb/3143760
    Start-Process -FilePath "icacls" -ArgumentList """$WINPE_WORKING_FOLDER\Windows\System32\schema.dat"" /save ""c:\temp\AclFile""" -Wait -NoNewWindow
    Start-Process -FilePath "takeown" -ArgumentList "/F ""$WINPE_WORKING_FOLDER\Windows\System32\schema.dat"" /A" -Wait -NoNewWindow
    Start-Process -FilePath "icacls" -ArgumentList """$WINPE_WORKING_FOLDER\Windows\System32\schema.dat"" /grant ""BUILTIN\Administrators:(F)""" -Wait -NoNewWindow
    Copy-Item -Path 'C:\Users\092782\Downloads\490343_ENU_x64_zip\Win10ADK-Hotfix-KB3143760\schema-x64.dat' -Destination "$WINPE_WORKING_FOLDER\Windows\System32\schema.dat"
    Start-Process -FilePath "icacls" -ArgumentList """$WINPE_WORKING_FOLDER\Windows\System32\schema.dat"" /setowner ""NT SERVICE\TrustedInstaller""" -Wait -NoNewWindow
    Start-Process -FilePath "icacls" -ArgumentList """$WINPE_WORKING_FOLDER\Windows\System32"" /restore ""c:\temp\AclFile""" -Wait -NoNewWindow

    Dismount-WindowsImage -Path "$WINPE_WORKING_FOLDER" -Save
}