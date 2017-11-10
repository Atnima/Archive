function New-EUC0365Package1
{
    [CmdletBinding()]
    param
    (
    )

    Begin
    {
        if (!$(Test-AdminStatus))
        {
            Write-Warning 'You need to be elevated to run this cmdlet'
            break;
        }
    }
    Process
    {

        $packages = @()
        $packages += New-Object PSObject -Property @{	Name = 'Office 365 Pro Plus inc. Visio and Project x64'
												        ConfigurationXml = 'proplusretail-visio-project-x64.xml'
												        DistributionFolder = 'proplusretail-visio-project'
                                                        Architecture = 'x64' }
        $packages += New-Object PSObject -Property @{	Name = 'Office 2013 Professional Plus Volume inc. Visio and Project Professional x64'
												        ConfigurationXml = 'proplusvolume-visio-project-pro-x64.xml'
												        DistributionFolder = 'proplusvolume-visio-project-pro'
                                                        Architecture = 'x64' }
        $packages += New-Object PSObject -Property @{	Name = 'Office 365 Pro Plus x86'
                                                        ConfigurationXml = 'proplusvolume-x86.xml'
                                                        DistributionFolder = 'proplusvolume'
                                                        Architecture = 'x86' }

        #$packageRoot = $((Get-PsEUCSettings).O365PackageRoot)
        $packageRoot = '\\m370prd1\PkgDev\Packages\MicrosoftOffice365ProPlus_15.n'
        $version = $(Get-LatestVersion -Path "$packageRoot\Development\o365-current\x64\Office\Data")
        Write-Verbose "Latest click to run version is : $version"

        # build each App-V package
        Write-Verbose 'Building App-V packages'
        foreach ($package in $packages)
        {
	        Write-Verbose "Processing package $($package.Name)"

	        # build App-V package
            if (-Not $(Test-Path "$packageRoot\Distribution\$($package.Architecture)\$($package.DistributionFolder)\$($version)"))
            {
                $processResult = Start-Process -FilePath "$packageRoot\Development\setup.exe" -ArgumentList "/packager ""$packageRoot\Development\$($package.ConfigurationXml)"" ""$packageRoot\Distribution\$($package.Architecture)\$($package.DistributionFolder)\$($version)""" -NoNewWindow -Wait
            }
            else
            {
                Write-Verbose 'Version of package already exists'
            }
        }
    }
}
