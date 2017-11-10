

<#

Get-EUCO365SourceFiles -O365SoftLibPath '\\m562prd1\src$\CM_Managed\Apps\Tier1\MicrosoftOffice365ProPlus_15.n'
Update-EUCO365SoftwareLibrary -O365SoftLibPath '\\m562prd1\src$\CM_Managed\Apps\Tier1\MicrosoftOffice365ProPlus_15.n'
New-EUCCMO365Application
Start-EUCCMTier1Deployment -ApplicationName ''

#>