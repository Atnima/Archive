function Get-EUCUserSid
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true)]
        [string]$SamAccountName,
        [string]$Domain = 'BCC'

    )

    $account = New-Object System.Security.Principal.NTAccount("bcc", "$SamAccountName")
    Write-Output "$($account.Translate([System.Security.Principal.SecurityIdentifier]))"
}

