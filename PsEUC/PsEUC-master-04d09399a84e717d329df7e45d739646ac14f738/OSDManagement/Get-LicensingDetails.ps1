function Get-LicenseStatusName
{
    param
    (
    [int]$LicenseStatus
    )

    switch ($LicenseStatus)
    {
        0	{ 'Unlicense' }
        1	{ 'Licensed' }
        2	{ 'OOBGrace' }
        3	{ 'OOTGrace' }
        4	{ 'NonGenuineGrace' }
        5	{ 'Notification' }
        6	{ 'ExtendedGrace' }
        default	{ 'Unknown' }
    }
}

function Get-LicensingDetails
{
	
    $licenses = Get-WmiObject SoftwareLicensingProduct | ? {$_.ProductKeyChannel -like '*volume*'}

    $licensesToReturn = @()

    foreach ($license in $licenses)
    {

        $licensesToReturn += New-Object PSObject -Property @{
		    Name = "$($license.Name)"
            Description = "$($license.Description)"
            KmsServer = "$($license.DiscoveredKeyManagementServiceMachineName)"
            Family = "$($license.LicenseFamily)"
            Channel = "$($license.ProductKeyChannel)"
		    RenewalIntervalInDays = [int]($($license.VLRenewalInterval) / 1440)
            Status = Get-LicenseStatusName -LicenseStatus $($license.LicenseStatus)
		    }
    }

    Write-Output $licensesToReturn

}

Get-LicensingDetails
