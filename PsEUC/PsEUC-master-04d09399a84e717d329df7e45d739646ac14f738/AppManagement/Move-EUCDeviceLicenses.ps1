

function Move-EUCDeviceLicenses
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true)]
        [string]$ComputerName,
        [Parameter(Mandatory=$true)]
        [string]$NewComputerName
    )

    $computer = Get-ADComputer $ComputerName -Properties MemberOf
    $newComputer = Get-ADComputer $NewComputerName
    
    $visioStandardExists = $($computer.MemberOf) -like "*Visio Standard*"
    $visioProfessionalExists = $($computer.MemberOf) -like "*Visio Professional*"

    # Visio - check pro first so we'll skip standard if both are assigned
    if ($visioProfessionalExists) {
        Write-Verbose 'Device currently assigned Visio Professional license'
        $visioStandardExists | ? { Remove-ADGroupMember -Identity $_ -Members $computer -Confirm:$false }
        Add-ADGroupMember -Identity $(Get-AdGroup 'Tier 2 - Microsoft Visio Professional 2013 15.0.4569.1506') -Members $newComputer
        Write-Verbose 'Visio Professional license transferred'
    }

    if ($visioStandardExists) {
        Write-Verbose 'Device currently assigned Visio Standard license'
        $visioStandardExists | ? { Remove-ADGroupMember -Identity $_ -Members $computer -Confirm:$false }
        if (-Not $visioProfessionalExists) {
            Add-ADGroupMember -Identity $(Get-AdGroup 'Tier 2 - Microsoft Visio Standard 2013 15.0.4569.1506') -Members $newComputer
            Write-Verbose 'Visio Standard license transferred'
        }
        else {
            Write-Verbose 'Visio Professional license transferred; skipping Visio Standard license transfer'
        }
    }
}
