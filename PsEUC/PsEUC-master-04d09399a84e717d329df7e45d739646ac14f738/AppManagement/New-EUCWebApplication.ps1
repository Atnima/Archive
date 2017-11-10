
<#
.Synopsis
   Short description
.EXAMPLE
    New-EUCWebApplication -Vendor 'Mincor' -Name 'CMX2' -Url 'http://cmx.bcc.qld.gov.au' -IeRequirement IE8-EntMode
#>
function New-EUCWebApplication
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$Vendor,
        [Parameter(Mandatory=$true)]
        [string]$Name,
        [Parameter(Mandatory=$true)]
        [string]$Url,
        [ValidateSet('IE8-EntMode', 'IE11', 'IE8-Citrix', 'IE9-Citrix', 'IE10-Citrix')]
        [string]$IeRequirement
    )

    $appName = "$Vendor $Name"

    New-CMApplication -Name "$appName" -Publisher "$Vendor"  -LocalizedApplicationName "$Name"
    Add-CMDeploymentType -ApplicationName "$appName" -WebAppInstaller -WebAppURL "$Url"
    Set-CMApplication -Name "$appName" -AppCategories 'Tier 2', 'Website' -UserCategories 'WebSite'

    if ($IeRequirement)
    {
        Set-CMApplication -Name "$appName" -AppCategories 'Tier 2', 'Website', "$IeRequirement"
    }

}
