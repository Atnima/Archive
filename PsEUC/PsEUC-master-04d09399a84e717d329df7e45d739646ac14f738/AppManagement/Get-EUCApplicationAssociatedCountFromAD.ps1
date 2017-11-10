function Get-EUCApplicationAssociatedCountFromAD
{
    [CmdletBinding()]
    Param
    (
    )

    $groups = Get-ADGroup -SearchBase 'OU=Prod,OU=Software Distribution Groups,OU=Groups,OU=BCC,DC=ad,DC=bcc,DC=qld,DC=gov,DC=au' -Filter *
    $results = @()
    foreach ($group in $groups)
    {
        $results += New-Object PSObject -Property @{	Name = $($group.Name)
												        MemberCount = $($group | Get-ADGroupMember).Count }
    }

    Write-Output $results
}
