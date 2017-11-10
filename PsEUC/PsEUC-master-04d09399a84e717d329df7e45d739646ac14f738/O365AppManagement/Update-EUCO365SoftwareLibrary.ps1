

<#
.Synopsis
   Short description
#>
function Update-EUCO365SoftwareLibrary
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$O365SoftLibPath
    )

    # version is the same for both arches
    $version = Get-EUCO365VersionFromSource -Path 'C:\Temp\o365package\x64\Office\Data'

    # copy the source files
    #Start-Process -FilePath robocopy -Wait -NoNewWindow -ArgumentList "C:\Temp\o365package\x64 $O365SoftLibPath\Distribution\CURRENT /s /e /np /njh /njs /copy:dat"
    #Start-Process -FilePath robocopy -Wait -NoNewWindow -ArgumentList "C:\Temp\o365package\x86 $O365SoftLibPath\Distribution\CURRENT /s /e /np /njh /njs /copy:dat"

    # remove standalone CAB files so auto-updates cannot function correctly
    if ($(Test-Path "$O365SoftLibPath\Distribution\CURRENT\Office\Data\v64.cab")) { Remove-Item -Path "$O365SoftLibPath\Distribution\CURRENT\Office\Data\v64.cab" }
    if ($(Test-Path "$O365SoftLibPath\Distribution\CURRENT\Office\Data\v32.cab")) { Remove-Item -Path "$O365SoftLibPath\Distribution\CURRENT\Office\Data\v32.cab" }

    # generate new deployment files (for initial installations)
    (New-EUCO365DeploymentFile -Version $($version.ToString()) -Bitness 64) | Set-Content "$O365SoftLibPath\Distribution\DEPLOY\proplusretail-x64-c2r-$($version.ToString()).xml"
    (New-EUCO365DeploymentFile -Version $($version.ToString()) -Bitness 32) | Set-Content "$O365SoftLibPath\Distribution\DEPLOY\proplusretail-x86-c2r-$($version.ToString()).xml"
    (New-EUCO365DeploymentFile -Version $($version.ToString()) -Bitness 64) | Set-Content "$O365SoftLibPath\Distribution\DEPLOY\proplusretail-x64-c2r-LATEST.xml"
    (New-EUCO365DeploymentFile -Version $($version.ToString()) -Bitness 32) | Set-Content "$O365SoftLibPath\Distribution\DEPLOY\proplusretail-x86-c2r-LATEST.xml"
}

