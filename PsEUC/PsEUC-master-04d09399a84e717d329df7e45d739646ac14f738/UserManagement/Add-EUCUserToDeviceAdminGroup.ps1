function Add-EUCUserToDeviceAdminGroup {
    [CmdletBinding()]
    param(
        [string]$ComputerName,
        [string]$UserAccount
    )
    
    New-ADGroup "$ComputerName Administrators" -GroupCategory Security -GroupScope DomainLocal -Path "OU=Specific MOE Admins,OU=Roles,OU=ICT,DC=ad,DC=bcc,DC=qld,DC=gov,DC=au"

    Get-ADGroup "$ComputerName Administrators" | Add-ADGroupMember -Members $(Get-AdUser $UserAccount)
}



