

<#
.Synopsis
   Download the latest source files for Office 365 Pro Plus from Microsoft. Assumes an Internet connection is available
#>
function Get-EUCO365SourceFiles
{
    [CmdletBinding()]
    Param
    (
        # The path to click to run setup.exe
        [Parameter(Mandatory=$true)]
        [string]$O365SoftLibPath
    )

    if (-Not $(Test-Path C:\Temp)) { New-Item C:\Temp -ItemType Directory }
    if (-Not $(Test-Path C:\Temp\o365package)) { New-Item C:\Temp\o365package -ItemType Directory }
    if (-Not $(Test-Path C:\Temp\o365package\x64)) { New-Item C:\Temp\o365package\x64 -ItemType Directory }
    if (-Not $(Test-Path C:\Temp\o365package\x86)) { New-Item C:\Temp\o365package\x86 -ItemType Directory }

    Copy-Item -Path "$O365SoftLibPath\Distribution\DEPLOY\setup.exe" -Destination 'C:\Temp\o365package'

    $xmlContentForx64Download = @"
<Configuration>
    <Add SourcePath="C:\Temp\o365package\x64" OfficeClientEdition="64" Branch="Current">
        <Product ID="O365ProPlusRetail">
            <Language ID="en-us" />
        </Product>
        <Product ID="VisioProRetail">
            <Language ID="en-us" />
        </Product>
        <Product ID="ProjectProRetail">
            <Language ID="en-us" />
        </Product>
    </Add>
    <Updates Enabled="FALSE" UpdatePath="\\Server\Share\" />
    <Property Name="AUTOACTIVATE" Value="1" />
</Configuration>
"@

    $xmlContentForx86Download = @"
<Configuration>
    <Add SourcePath="C:\Temp\o365package\x86" OfficeClientEdition="32" Branch="Current">
        <Product ID="O365ProPlusRetail">
            <Language ID="en-us" />
        </Product>
        <Product ID="VisioProRetail">
            <Language ID="en-us" />
        </Product>
        <Product ID="ProjectProRetail">
            <Language ID="en-us" />
        </Product>
    </Add>
    <Updates Enabled="FALSE" UpdatePath="\\Server\Share\" />
    <Property Name="AUTOACTIVATE" Value="1" />
</Configuration>
"@

    Set-Content -Path 'C:\Temp\o365package\download-x64.xml' -Value $xmlContentForx64Download
    Set-Content -Path 'C:\Temp\o365package\download-x86.xml' -Value $xmlContentForx86Download

    Set-Location -Path 'C:\Temp\o365package'
    Start-Process -FilePath '.\setup.exe' -ArgumentList '/download download-x64.xml' -Wait -NoNewWindow
    Start-Process -FilePath '.\setup.exe' -ArgumentList '/download download-x86.xml' -Wait -NoNewWindow

}
