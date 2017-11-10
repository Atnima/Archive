function New-Shortcut
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [string]$ShortcutFilePath,
        [Parameter(Mandatory=$true)]
        [string]$TargetFilePath,
        [string]$Arguments,
        [string]$Description,
        [string]$WorkingDirectory,
        # notepad.exe, 0
        [string]$IconLocation,
        [switch]$Overwrite
    )

    if ($(Test-Path "$ShortcutFilePath"))
    {
        if ($Overwrite)
        {
            Remove-Item "$ShortcutFilePath"
        }
        else
        {
            Write-Error 'Shortcut file already exists'
        }
    }

    try
    {
        $shell = New-Object -ComObject WScript.Shell
        $shortcut = $shell.CreateShortcut($ShortcutFilePath)
        $shortcut.TargetPath = "$TargetFilePath"

        if ($Arguments)
        {
            $shortcut.Arguments = "$Arguments"
        }

        if ($Description)
        {
            $shortcut.Description = "$Description"
        }

        if ($WorkingDirectory)
        {
            $shortcut.WorkingDirectory = "$WorkingDirectory"
        }

        if ($IconLocation)
        {
            $shortcut.IconLocation = "$IconLocation"
        }

        $shortcut.Save()
    }
    catch
    {
        Write-Error 'Failed to create shortcut'
    }
}