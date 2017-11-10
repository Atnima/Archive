function Get-EUCUserPrimaryComputer
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Payroll
    )

    [System.Collections.ArrayList]$assets1 = @(Invoke-CMWmiQuery -Query "Select * from SMS_R_SYSTEM WHERE LastLogonUserName = '$Payroll'")
    [System.Collections.ArrayList]$assets2 = @(Invoke-CMWmiQuery -Query @"
select * from SMS_R_SYSTEM
inner join SMS_UserMachineRelationship on SMS_UserMachineRelationship.ResourceName = SMS_R_SYSTEM.Name
where SMS_UserMachineRelationship.UniqueUserName = 'bcc\\$Payroll'
"@)

    [System.Collections.ArrayList]$assets = @($assets1 | % { Write-Output $_.Name })
    $assets += @($assets2 | % { Write-Output $_.SMS_R_SYSTEM.Name })

    Write-Output $assets | Sort-Object | Get-Unique
}
