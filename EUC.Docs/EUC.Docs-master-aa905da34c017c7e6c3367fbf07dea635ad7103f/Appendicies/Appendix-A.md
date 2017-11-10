## Appendix A - Admin Hints

### Add Early Adopter Devices to AD Group

~~~~ powershell
$devices = Get-CMCollectionMember -CollectionName 'BCC MOEvNext - Windows 10 - PRODX OU - Early Adopter Devices' | % { Add-ADGroupMember -Identity 'Tier 1 - EUC-PRD-C-Firewall-MOE-X Transition - Devices' -Members $(Get-ADComputer $_.Name) }
~~~~e

### Add Random Computers to Active Directory Group

~~~~ powershell
Get-ADComputer -SearchBase 'OU=PRODX,OU=MOENext,OU=Computers,OU=BCC,DC=ad,DC=bcc,DC=qld,DC=gov,DC=au' -SearchScope Subtree -Filter { Enabled -eq $true } | Get-Random -Count 100 | % { Add-ADGroupMember -Identity 'Tier 1 - EUC-PRD-C-Firewall-MOE-X Transition - Devices' -Members $_ }
~~~~
