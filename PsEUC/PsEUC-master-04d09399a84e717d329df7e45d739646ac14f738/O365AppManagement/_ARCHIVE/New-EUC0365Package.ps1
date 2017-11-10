function New-EUC0365Package
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$Path,
        [Parameter(Mandatory=$true)]
        [string]$ConfigXml,
        [Parameter(Mandatory=$true)]
        [string]$FolderName,
        [Parameter(Mandatory=$true)]
        [ValidateSet('x86', 'x64')]
        [System.String]$Architecture
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
        $version = $(Get-LatestVersion -Path "$Path\Development\o365-current\$Architecture\Office\Data")
        Write-Verbose "Latest click to run version is : $version"

	    # build App-V package
        if (-Not $(Test-Path "$Path\Distribution\$Architecture\$FolderName\$($version)"))
        {
            Write-Verbose 'Generating App-V package'
            Start-Process -FilePath "$Path\Development\setup.exe" -ArgumentList "/packager ""$Path\Development\$ConfigXml"" ""$Path\Distribution\$Architecture\$FolderName""" -NoNewWindow -Wait
        }
        else
        {
            Write-Verbose 'Version of App-V package already exists'
        }
    }
}
