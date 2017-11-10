function Switch-ADComputerGroupMember
{
    <#
    .SYNOPSIS
    Switch the group membership of a computer
    .DESCRIPTION
    Switch the membership of a computer from one security group to another by removing it from one and adding to the other. Used to assist with application upgrades
    .LINK
    None
    #>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true)]
        [string]$Computer,
        [Parameter(Mandatory=$true)]
        [string]$CurrentGroup,
        [Parameter(Mandatory=$true)]
        [string]$NewGroup
    )

    process
    {
        $adComputer = Get-ADComputer $Computer
        Remove-ADGroupMember $CurrentGroup -Members $adComputer -Confirm:$false
        Add-ADGroupMember $NewGroup -Members $adComputer
    }
}
