function Add-ComputerToDomain
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$Domain,
        [Parameter(Mandatory=$true)]
        [string]$OUPath,
        [Parameter(Mandatory=$true)]
        [string]$Username,
        [Parameter(Mandatory=$true)]
        [string]$Password,
        [switch]$NoOverwrite
    )

    # https://msdn.microsoft.com/en-us/library/aa392154(v=vs.85).aspx
    # JOIN_DOMAIN + ACCT_CREATE
    $JOIN_OPTION_NEW = 3
    # JOIN_DOMAIN + DOMAIN_JOIN_IF_JOINED
    $JOIN_OPTION_IFJOINED = 33

    $computer = Get-WmiObject Win32_ComputerSystem
    $result = $computer.JoinDomainOrWorkGroup($Domain, $Password, $Username, $OUPath, $JOIN_OPTION_NEW)
    
    if ($($result.ReturnValue) -eq 2224) {
        # machine account already exists in domain, so we attempt to overwrite it
        if (-Not $NoOverwrite) {
            Write-Verbose 'Overwriting existing computer account'
            $result = $computer.JoinDomainOrWorkGroup($Domain, $Password, $Username, $OUPath, $JOIN_OPTION_IFJOINED)
        } else {
            Write-Verbose 'No attempt was made to overwrite existing computer account'
        }
    }
    
    if ($($result.ReturnValue) -eq 0) {
        Write-Verbose 'Added computer to the domain. A restart is required to take effect'
        Write-Output $true
    } else {
        Write-Verbose "Computer was not added to the domain. Error : $($result.ReturnValue)"
        Write-Output $false
    }
}

#Add-ComputerToDomainToDomain -Domain 'BCC' -OUPath 'OU=Thin,OU=MOENext,OU=Computers,OU=BCC,OU=ad,OU=bcc,OU=qld,OU=gov,OU=au'
