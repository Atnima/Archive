<#
.SYNOPSIS
    Deploy a tier 1 application to the organisation
.DESCRIPTION
    Using a staggered approach, the application will be deployed to the organisation using multiple device collections.
.EXAMPLE
    Start-EUCCMTier1Deployment -ApplicationName 'Microsoft Visual Studio 2015 Professional 15.0.22.2'
#>
function Get-EUCRandomDate
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [DateTime]$StartDate,
        [Parameter(Mandatory=$true)]
        [DateTime]$FinishDate
    )
 
    Get-Random -Maximum $FinishDate.Ticks -Minimum $StartDate.Ticks | Get-Date
}

#Get-EUCRandomDate -StartDate $((Get-Date).AddDays(2)) -FinishDate $((Get-Date).AddDays(4))