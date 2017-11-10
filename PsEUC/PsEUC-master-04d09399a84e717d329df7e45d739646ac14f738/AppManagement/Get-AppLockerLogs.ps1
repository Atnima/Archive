function Get-AppLockerLogs
{
    [CmdletBinding()]
    Param
    (
        $Minutes = 60
    )

    $appLockerLogs = Get-WinEvent 'Microsoft-Windows-AppLocker/EXE and DLL' -ErrorAction SilentlyContinue | ? { ($_.TimeCreated -gt $(Get-Date).AddMinutes($(0 - $Minutes))) -and ($_.LevelDisplayName -ne 'Information') }
    $appLockerMsiLogs = Get-WinEvent 'Microsoft-Windows-AppLocker/MSI and Script' -ErrorAction SilentlyContinue | ? { ($_.TimeCreated -gt $(Get-Date).AddMinutes($(0 - $Minutes))) -and ($_.LevelDisplayName -ne 'Information') }

    if ($appLockerMsiLogs) { $appLockerLogs += $appLockerMsiLogs }

    $appLockerLogs
}

