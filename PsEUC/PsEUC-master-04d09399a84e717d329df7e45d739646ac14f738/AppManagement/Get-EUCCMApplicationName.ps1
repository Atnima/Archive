function Get-EUCCMApplicationName
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        $Vendor,
        [Parameter(Mandatory=$true)]
        $Name,
        [Parameter(Mandatory=$true)]
        $Version
    )

    New-Object PSObject -Property @{
		    LongName = "$Vendor $Name $Version"
		    ShortName = "$(Get-CleanString -Value $Vendor)$(Get-CleanString -Value $Name)_$($Version)"
            LongNameNoVersion = "$Vendor $Name"
	}
}
