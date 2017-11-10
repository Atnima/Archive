## Application Notes
### Naming Standards
The information provided below is an addendum to [CA11/308457 Desktop Infrastructure - Application Packaging Guidelines and Best Practices for BCC](trim://CA11%2f308457?db=C1&view).

#### Applications

* the name of the application in Config Mgr should be *"vendor application version"*. If there is a new revision of the application with the same version, *(REV0X)* may be appended to the end of the name. Some examples include:
	* Oracle SQL Developer 4.1.2.20
	* SAP GUI for Windows 7300.2.58949 (REV08)
* the version of the application should match the version of the binary files that are installed, not the marketing product version (which would be included in the application name). For example
	* Microsoft SQL Server 2016 Management Studio 13.0.15000.23
* one exception to the above guideline is when there is a *packaging* revision to an application; in this case append *+revX* to the end of the version number. For example:
	*  7300.2.58949+rev8 (for SAP GUI for Windows 7300.2.58949 (REV08))
* on the *Application Catalogue* tab of the application, the *Localized application name* should be a user friendly name of the application, for example *SQL Server 2016 Management Studio June 2016* instead of *Microsoft SQL Server 2016 Management Studio 13.0.15000.23*. The vendor and version fields displayed in the *Software Centre* are taken from the *General Information* tab

#### Collections

* where possible applications should be deployed to *All Users* to enable self service. When a device collection is required the following convention applies - *App Deploy - vendor application version*

### Icons for Software Centre
For all tier 1 and tier 2 applications icons should be added to the *Application Catalogue* tab of the application properties. Icons can be copied to `\\m562prd1\src$\cm_managed\icons` and use the `\\m562prd1\icons$` share in the application properties.

#### Extracting Icons
I haven't found a good tool that grabs an existing application icon and outputs an `.ico` file with multiple resolutions. As an interim solution use [IconExport](https://www.powershellgallery.com/packages/IconExport/2.0.0).

~~~~
Import-Module '\\m562prd1\PsModules$\IconExport'
Export-Icon -Path 'C:\Program Files\Client Center for Configuration Manager\SCCMCliCtrWPF.exe' -Directory 'c:\temp'
~~~~

### Deployment Type Tips

* when publishing an MSI or EXE application to a user collection, check the *Installation behaviour* dropdown on the *User Experience* tab in the deployment type properties, and make sure it is set to `Install for system`. Please note that if the app **can** install per user, this will obviously change how this should be configured

#### Installation Commands
##### User-scoped Shortcuts
Use a PowerShell script function to create a user-scoped shortcut, in this case to open Chrome in web-app mode:

~~~~ bat
:: install command
powershell -executionpolicy bypass -noprofile -file \\m562prd1\src$\CM_Managed\PowerShell\Scripts\New-Shortcut.ps1 -ShortcutFilePath "%APPDATA%\Microsoft\Windows\Start Menu\VMware vSphere Web Client.lnk" -TargetFilePath "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" -Arguments "--app=https://m117prd3.bcc.qld.gov.au:9443/vsphere-client --ignore-certificate-errors" -Description "VMware vSphere Web Client" –Overwrite
~~~~

~~~~ ps1
# detection rule
if (Test-Path "$($env:APPDATA)\Microsoft\Windows\Start Menu\VMware vSphere Web Client.lnk") { Write-Output $true }
~~~~

~~~~ bat
:: uninstall command
powershell -executionpolicy bypass -noprofile -command "Remove-Item ""%APPDATA%\Microsoft\Windows\Start Menu\VMware vSphere Web Client.lnk"""
~~~~

#### Detection Rules
##### Windows Updates

~~~~ ps1
try
{
	if ($(Get-WmiObject -Class Win32_QuickFixEngineering -Filter { HotFixID = 'KB2693643' })) { write-output 'Installed' }
}
catch {}
~~~~

##### User-scoped Shortcuts
Using environment variables such as `%APPDATA%` don't work against the file rule; a script detection method is the only option.

~~~~ ps1
try
{
	Test-Path "$($env:APPDATA)\Microsoft\Windows\Start Menu\VMware vSphere Web Client.lnk"
}
catch {}
~~~~


#### User licensed apps

This application is licensed per user. Although the application may install, you will be unable to utilise it until you have procured a valid license. For further details, click "Additional information" below.

This application has a number of additional functions that are licensed per user. If you wish to utilise these functions you will need to procure a valid license. For further details on licensing, click "Additional information" below.

http://m563prd1.bcc.qld.gov.au/user-docs/guides/apps/#licensed-apps:c6a4be2f6b503cc5d5e20765edc3f3ee


#### Icons
best looking
http://converticon.com/
create png 128 x 128

### PSWebExec

### Detection Rules
#### PowerShell Scripts
There are some gotcha's to watch out for when using PowerShell scripts as the detection logic:

1. An application deployed with a user deployment type, will execute the PowerShell script in the user context. Conversely a system/machine deployment type will be executed in the `SYSTEM` context. **In the case of a user deployment type, this means the PowerShell script will load the profile of the user**
2. Regardless of whether an application is found, if the exit code of the script is `0` and **some output** is returned, Config Mgr will report the app as being detected. **The trick is to return nothing if the app is not found**

##### Examples

~~~~
# only return a true value if the app is found, otherwise return nothing
if (Test-Path "$($env:APPDATA)\Microsoft\Windows\Start Menu\VMware vSphere Web Client.lnk") { Write-Output $true }
~~~~

~~~~
# if this command returns no objects, it returns an error so we need to catch and hide this
try
{
	if ($(Get-WmiObject -Class Win32_QuickFixEngineering -Filter { HotFixID = 'KB2693643' })) { write-output 'Installed' }
}
catch {}
~~~~

##### More Info
* [http://blog.kloud.com.au/2014/08/12/powershell-detection-method-for-sccm-2012-application-compliance-management/](http://blog.kloud.com.au/2014/08/12/powershell-detection-method-for-sccm-2012-application-compliance-management/)
* [http://serverfault.com/questions/699705/in-what-context-do-sccm-powershell-detection-scripts-run-in](http://serverfault.com/questions/699705/in-what-context-do-sccm-powershell-detection-scripts-run-in)

### Configuration Baselines

#### C-BL - MOE - Windows 10 - TEST

#### C-BL - MOE - Windows 10

##### Configuration Items
###### CI - StartupAppTask Scheduled Task
The `StartupAppTask` generates a notification to the user on logon regarding which applications delayed the boot sequence. As we don't allow users to manage this, the scheduled task is disabled.

~~~~ ps1
# discovery script
if (Get-ScheduledTask -TaskName StartupAppTask | ? { $_.State -eq 'Disabled' }) {
    Write-Output $true
} else {
    Write-Output $false
}
~~~~

~~~~ ps1
# remediation script
Get-ScheduledTask -TaskName StartupAppTask | Disable-ScheduledTask
~~~~

###### CI - MOEvNext Assets Package
This CI checks for the existence of the `NewPinnedShortcuts.vbs` file and if it is not found, performs a removal of the MSI package so it can be reinstalled (which the app deployment eval triggers).

A bug was indentified that on occasion devices would upgrade from one assets package to the next, and it would not be a clean upgrade. A typical sympton was a missing `NewPinnedShortcuts.vbs` file.

~~~~
# discovery script
Test-Path -Path 'C:\Program Files\BCC\Assets\NewPinnedShortcuts.vbs'
~~~~

~~~~
# remediation script
try {
    Expand-Archive -Path '\\m562prd1\PsModules$\MSI_3.1.3.1.zip' 'C:\Program Files\WindowsPowerShell\Modules\MSI' -Force
    Import-Module MSI
    Get-MSIProductInfo -Name "MOEvNext Assets" | Uninstall-MSIProduct
    Start-Sleep -Seconds 10

    # trigger app deployment policy refresh
    ([wmiclass]"\\.\root\ccm:sms_client").TriggerSchedule("{00000000-0000-0000-0000-000000000121}")

    Write-Output $true
}
catch {
    Write-Output $false
}
~~~~

###### CI - Asset Tag
Tests whether the device has an appropriate asset tag.

~~~~
# discovery script
function Test-AssetTag
{
    [CmdletBinding()]
    [OutputType([bool])]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        $AssetTag
    )

    Write-Output $($assetTag -match '([D,N])\d{6}$')
}

$assetTagFromWmi = (Get-WmiObject Win32_SystemEnclosure).SMBIOSAssetTag
if (($assetTagFromWmi.Count) -gt 1) { $assetTagFromWmi = $assetTagFromWmi[0] }
if ($assetTagFromWmi -eq $null) { $assetTagFromWmi = '' }
Test-AssetTag -AssetTag $assetTagFromWmi -ErrorAction SilentlyContinue
~~~~

###### CI - CCMExec DependsOn
Adds a dependency to the smstsmgr service to resolve an issue with an application continuosuly attempting to install.
https://gallery.technet.microsoft.com/Fix-for-Software-Center-b16a6076
~~~~
# discovery script
$service = get-service smstsmgr
if (($service.ServicesDependedOn).Name -notcontains "ccmexec") {
    Write-Output $false
} else {
    Write-Output $true
}
~~~~

~~~~
# remediation script
Start-Process -FilePath 'sc.exe' -ArgumentList "config smstsmgr depend= winmgmt/ccmexec" -Wait
~~~~

###### CI - Firewall Rules
Create local firewall rules.

~~~~
# discovery script
if (Get-NetFirewallRule -Name '857fcd76d7f540ebb50f56e5f23b52a3' -ErrorAction SilentlyContinue) {
    Write-Output $true
} else {
    Write-Output $false
}
~~~~

~~~~
# remediation script
New-NetFirewallRule -Name 857fcd76d7f540ebb50f56e5f23b52a3 -DisplayName 'Lync-Domain-TCP' -Profile Domain,Private,Public -EdgeTraversalPolicy Block -LooseSourceMapping $false -LocalOnlyMapping $false -Action Allow -Protocol TCP -Program 'c:\Program Files\Microsoft Office\root\Office16\lync.exe'
~~~~


### Global Conditions
#### Secure Boot

* Device Type : Windows
* Condition Type : Setting
* Setting type : Script
* Data type : Boolean

~~~~ ps1
try
{
    Write-Output $(Confirm-SecureBootUEFI -ErrorAction SilentlyContinue)
}
catch
{
    Write-Output $false
}
~~~~

#### Office 365 Pro Plus Version

* Device Type : Windows
* Condition Type : Setting
* Setting type : Registry value
* Data type : Version
* Hive : HKLM
* Key : SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\O365ProPlusRetail - en-us
* Name : DisplayVersion

### Software Updates
#### Automatic Deployment Rules

