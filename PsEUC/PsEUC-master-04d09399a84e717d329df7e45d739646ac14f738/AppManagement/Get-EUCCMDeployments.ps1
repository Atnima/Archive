function Get-EUCCMDeployments
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        $CollectionName = 'BCC MOEvNext*'
    )

    $collections = Get-CMDeviceCollection -Name "$CollectionName" | Sort-Object Name
    foreach ($col in $collections)
    {
        Write-Output '*******************************************'
        Write-Output "Collection : $($col.Name)"
        Write-Output '*******************************************'

        foreach ($deployment in $(Get-CMDeployment -CollectionName $($col.Name) | Sort-Object SoftwareName))
        {
            Write-Output "$($deployment.SoftwareName)"
        }
    }
}
