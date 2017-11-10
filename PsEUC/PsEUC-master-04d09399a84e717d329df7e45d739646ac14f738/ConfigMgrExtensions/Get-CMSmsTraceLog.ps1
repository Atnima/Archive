function Get-CMSmsTraceLog {
    [CmdletBinding()]
    param(
        [string]$ComputerName
    )

    Start-Process -FilePath  \\m370prd1\pkgdev\tools\CMTrace.exe -ArgumentList "\\$ComputerName\c`$\windows\SysWOW64\CCM\Logs\smsts.log"

}
