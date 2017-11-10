
function Remove-UserLocalProfile
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true)]
        [string]$Payroll,
        [Parameter(Mandatory=$true)]
        [string]$ComputerName

    )

    $sid = ((Get-ADUser $Payroll).SID).Value
    $session = New-PSSession -ComputerName $ComputerName
    $script = @"
Remove-Item "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\$sid" -Recurse -Force
Remove-Item "C:\Users\$Payroll" -Recurse -Force
"@

    Invoke-Command -Session $session -ScriptBlock $([Scriptblock]::Create($script))
    Remove-PSSession -Session $session
}

#Remove-UserLocalProfile -Payroll 092782 -ComputerName tmp012003
