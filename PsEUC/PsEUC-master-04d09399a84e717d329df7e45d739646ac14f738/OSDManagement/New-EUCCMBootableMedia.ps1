
<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function New-EUCCMBootableMedia
{
    [CmdletBinding()]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true)]
        $IsoFile,
        [Parameter()]
        $UsbDriveLetter = ''
    )

    Process
    {
        Write-Verbose 'Creating ISO file'
        Start-Process -FilePath "$($env:SMS_ADMIN_UI_PATH)\CreateMedia.exe" -Wait -NoNewWindow -ArgumentList "/K:boot /P:m562prd1.ad.bcc.qld.gov.au /D:m562prd1.ad.bcc.qld.gov.au /S:KA1 /L:Boot /Z:false /X:""SMSTSMP=http://m562prd1.ad.bcc.qld.gov.au"" /B:KA100124 /E:KA10010D /T:CD /F:""c:\temp\blah.iso"""

        if ($UsbDrive -ne '')
        {
            Write-Verbose 'Updating USB media'
            Format-Volume -DriveLetter $UsbDriveLetter -FileSystem FAT32 -NewFileSystemLabel CMBOOT -Confirm:$false
            Start-Process -FilePath "\\m562prd1\src$\CM_Managed\Tools\7z.exe" -Wait -NoNewWindow -ArgumentList "x -o""$($UsbDriveLetter):"" ""$IsoFile"""
        }
    }
}

