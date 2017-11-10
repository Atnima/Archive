function Disable-ADComputer
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true)]
        [string]$OuName,
        [int]$Days = 100,
        [switch]$AuditOnly
    )

    #$ou = $((Get-EUCSetting -Group AdWorkstationOu | ? { $_.FriendlyName -eq "$OuName" }).OU)
    $ou = $OuName
    $disableDate = [DateTime]::Today.AddDays(-($Days))
    $toDisable = Get-ADComputer -Filter {(enabled -eq 'true') -and (lastLogonTimestamp -le $disableDate)} -Properties lastLogonTimestamp -SearchBase "$ou"
    $toDisable += Get-ADComputer -Filter {(enabled -eq 'true') -and (lastLogonTimestamp -notlike '*')} -Properties lastLogonTimestamp -SearchBase "$ou"

    if (-Not $AuditOnly)
    {
        $toDisable | % { Set-ADComputer $_ -Enabled $false }
    }
    else
    {
        Write-Output $toDisable
    }
}
