
function Get-EUCUser
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        [string]$Name
    )

    Get-ADUser -Filter { DisplayName -like $Name } -SearchBase 'OU=Internal Users,OU=Users,OU=BCC,DC=ad,DC=bcc,DC=qld,DC=gov,DC=au'
}


