<#
.SYNOPSIS
    Deploy a tier 1 application to the organisation
.DESCRIPTION
    Using a staggered approach, the application will be deployed to the organisation using multiple device collections.
.EXAMPLE
    Start-EUCCMTier1Deployment -ApplicationName 'Microsoft Visual Studio 2015 Professional 15.0.22.2'
#>
function Format-XML
{
    <#
    .SYNOPSIS
    Return a formatted XML document
    .DESCRIPTION
    Take a file or raw string input, and ouput a nicely formatted XML string
    .LINK
    None
    #>
    [CmdletBinding(DefaultParameterSetName='FileParamSet')]
    param
    (
        [parameter(Position=0, Mandatory=$true, ParameterSetName='FileParamSet')]
        [string]$File,
        [parameter(Position=0, Mandatory=$true, ParameterSetName='ContentParamSet')]
        [xml]$XmlContent,
        [parameter(Position=1)]
        [string]$Indent = 4
    )

    begin {
        # if XmlContent is null, try and process the file
        if ($XmlContent -eq $null)
        {
            try
            {
                $XmlContent = Get-Content $File -Raw
            }
            catch
            {
                throw (Write-Error $Error[0])
            }
        }
    }

    process
    {
        if ($XmlContent -ne $null)
        {

            #[xml]$xml = $XmlContent
            $stringWriter = New-Object System.IO.StringWriter 
            $xmlTextWriter = New-Object System.XMl.XmlTextWriter $stringWriter 
            $xmlTextWriter.Formatting = 'indented' 
            $xmlTextWriter.Indentation = $Indent 
            $XmlContent.WriteContentTo($xmlTextWriter) 
            $xmlTextWriter.Flush() 
            $stringWriter.Flush() 
            Write-Output $stringWriter.ToString()
        }
    }
}