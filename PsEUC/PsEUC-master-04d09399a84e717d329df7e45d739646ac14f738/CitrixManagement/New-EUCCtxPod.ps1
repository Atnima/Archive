function New-EUCCtxPod
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true)]
        [string]$SiteName
    )

    New-XDDataBase -SiteName "$SiteName" -DataStore Site -DatabaseServer .\SQLExpress -DatabaseName "$($SiteName)_Site"
    New-XDDataBase -SiteName "$SiteName" -DataStore Logging -DatabaseServer .\SQLExpress -DatabaseName "$($SiteName)_Logging"
    New-XDDataBase -SiteName "$SiteName" -DataStore Monitor -DatabaseServer .\SQLExpress -DatabaseName "$($SiteName)_Monitoring"

    New-XDSite -SiteName "$SiteName" -DatabaseServer .\SQLExpress -LoggingDatabaseName "$($SiteName)_Logging" -MonitorDatabaseName "$($SiteName)_Monitoring" -SiteDatabaseName "$($SiteName)_Site"

    ## ???? we need to enable SQL browser? how can we not do this?
    Get-Service SQLBrowser | Set-Service -StartupType Automatic
    Get-Service SQLBrowser | Start-Service

    Import-Module 'C:\Program Files\Citrix\Licensing\SnapIn\Citrix.Licensing.Admin.V1\Citrix.LicensingAdmin.PowerShellSnapIn.dll'
    Import-Module 'C:\Program Files\Citrix\Configuration\SnapIn\Citrix.Configuration.Admin.V2\Citrix.Configuration.PowerShellSnapIn.dll'
    $cert = Get-LicCertificate  -AdminAddress 'https://localhost:8083'
    Import-LicLicenseFile  -AdminAddress 'https://localhost:8083' -CertHash $($cert.CertHash) -FileName '\\m370prd1\PkgDev\XenDesktop-XenApp-Early-Release-Expires-20160331-All-Editions.lic'
    Set-ConfigSite  -AdminAddress "$($env:COMPUTERNAME).ad.bcc.qld.gov.au:80" -LicenseServerName "$($env:COMPUTERNAME).ad.bcc.qld.gov.au:80" -LicenseServerUri "https://$($env:COMPUTERNAME).ad.bcc.qld.gov.au:8083/"


}

