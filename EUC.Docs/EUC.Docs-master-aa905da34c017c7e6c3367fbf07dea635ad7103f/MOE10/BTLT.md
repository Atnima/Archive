## Brisbane Transport Learning Tablet
The Brisbane Transport Learning Tablet is a solution that involves using a standard Windows 10 MOE, however a local user account has been provisioned and it is used to automatically log on to the device. In addition *kiosk* mode has been activated, allowing only SAP (via Internet Explorer) as the user interface.

### Configuring a Device

1. build a device with the Windows 10 MOE. Surface 3 devices have only been specifically tested
1. assign the device to the `Tier 1 - BCC BTLT 1.0.0.0 - TS` Active Directory group
1. wait for the task sequence to automatically execute and reboot the device

### Installation Details

Installation is performed by an SCCM task sequence that runs the script below (original can be found at `\\m562prd1\src$\CM_Managed\Apps\Tier1\BCCBrisbaneTransportSAPTabletWindows10_1.0.0.0\Distribution\x64\REV01`) and then moves the PC to the correct OU.

~~~~ powershell
function Get-AccountSID
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true)]
        $AccountName
    )

    $ntAccount = New-Object System.Security.Principal.NTAccount($AccountName)
    $userSecId = $ntAccount.Translate([System.Security.Principal.SecurityIdentifier])

    Write-Output $($userSecId.Value)
}

# https://technet.microsoft.com/itpro/windows/manage/set-up-a-kiosk-for-windows-10-for-desktop-editions

$USER_ACCOUNT = "$($env:COMPUTERNAME)\btlt"
# TODO : update accordingly
$USER_PASSWORD = 'EnterPasswordHere'
$RESTART_SHELL = 0
$LAUNCH_SHELL_COMMAND = 'c:\program files\internet explorer\iexplore.exe -private https://sapportalint.bcc.qld.gov.au/irj/portal'

Enable-WindowsOptionalFeature -FeatureName 'Client-EmbeddedShellLauncher' -Online

$password = ConvertTo-SecureString -String $USER_PASSWORD -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $USER_ACCOUNT, $password

Import-Module "$PSScriptRoot\Carbon"
Install-User -Credential $cred -Description 'Brisbane Transport Learning Tablet' -FullName 'BTLT' -UserCannotChangePassword
Add-GroupMember -Name 'Users' -Member $USER_ACCOUNT
Add-GroupMember -Name 'Remote Desktop Users' -Member $USER_ACCOUNT

$shellLauncher = [wmiclass]"\\.\root\standardcimv2\embedded:WESL_UserSetting"
$userSid = Get-AccountSID -Account $USER_ACCOUNT

try {
    # remove if required during testing
    $shellLauncher.RemoveCustomShell($userSid)
}
catch { }

$shellLauncher.SetCustomShell($userSid, $LAUNCH_SHELL_COMMAND, $null, $null, $RESTART_SHELL)
$shellLauncher.SetEnabled($true)

# create autologon registry keys
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name AutoAdminLogon -Value 1 -PropertyType String -Force
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name DefaultUserName -Value 'btlt' -PropertyType String -Force
New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name DefaultPassword -Value $USER_PASSWORD -PropertyType String -Force
~~~~