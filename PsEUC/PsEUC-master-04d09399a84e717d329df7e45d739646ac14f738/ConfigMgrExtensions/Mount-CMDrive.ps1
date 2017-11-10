function Mount-CMDrive
{
    [CmdletBinding()]
    Param
    (
    )

    Get-PSDrive KA1 -ErrorAction SilentlyContinue | Remove-PSDrive
    New-PSDrive -PSProvider cmsite -Name KA1 -Root m562prd1.ad.bcc.qld.gov.au -Scope Global
}
