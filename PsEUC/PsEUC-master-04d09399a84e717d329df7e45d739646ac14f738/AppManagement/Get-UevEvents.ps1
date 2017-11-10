function Get-UevEvents
{
    (Get-WinEvent 'Microsoft-User Experience Virtualization-IPC/Operational' -ErrorAction SilentlyContinue | ? { ($_.TimeCreated -gt $(Get-Date).AddMinutes(-1)) }).Message | ConvertFrom-Json -ErrorAction SilentlyContinue| select Description, TemplateId
}



