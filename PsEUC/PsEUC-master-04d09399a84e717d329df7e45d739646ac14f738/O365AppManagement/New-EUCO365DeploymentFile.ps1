function New-EUCO365DeploymentFile
{
    [CmdletBinding()]
    [OutputType([string])]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$Version,
        [Parameter(Mandatory=$true)]
        [string]$Bitness
    )

    Process
    {
        $xmlContent = @"
<Configuration>
    <Add SourcePath="\\m562prd1\o365-current$" OfficeClientEdition="$Bitness" Version="$Version">
        <Product ID="O365ProPlusRetail">
            <Language ID="en-us" />
	        <ExcludeApp ID="Access" />
        </Product>
    </Add>
    <Updates Enabled="FALSE" />
    <Display Level="None" AcceptEULA="TRUE" />
    <Logging Path="%TEMP%" />
</Configuration>
"@

        Write-Output $xmlContent
    }
}