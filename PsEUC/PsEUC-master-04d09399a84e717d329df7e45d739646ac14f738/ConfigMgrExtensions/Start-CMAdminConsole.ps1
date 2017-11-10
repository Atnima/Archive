function Start-CMAdminConsole
{
    [CmdletBinding()]
    Param
    (
    )

    Start-Process -FilePath "$env:SMS_ADMIN_UI_PATH\..\Microsoft.ConfigurationManagement.exe"
}
