function Get-EUCInstalledApplications
{
    [CmdletBinding()]
    Param
    (
    )

    $applications = @()
    foreach ($item in $(Get-ChildItem -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'))
    {
        $props = $item | Get-ItemProperty
        if ($($props.DisplayName -notlike ''))
        {
            if ([bool]$($props.WindowsInstaller)) { [System.Guid]$productCode = $($item.PSChildName) } else { $productCode = [System.Guid]::Empty }
            $applications += New-Object PSObject -Property @{	RegistryPath = $($item.Name)
                                                                Version = $($props.DisplayVersion)
                                                                HelpLink = $($props.HelpLink)
                                                                ModifyCommand = $($props.ModifyPath)
                                                                Vendor = $($props.Publisher)
                                                                UninstallCommand = $($props.UninstallString)
                                                                IsWindowsInstaller = [bool]$($props.WindowsInstaller)
                                                                Name = $($props.DisplayName)
                                                                MoreInfoLink = $($props.MoreInfoURL)
                                                                AboutLink = $($props.URLInfoAbout)
                                                                ParentKey = $($props.ParentKeyName)
                                                                ParentName = $($props.ParentDisplayName)
                                                                ProductCode = $productCode
                                                                Architecture = 'x64' }
        }
    }

    foreach ($item in $(Get-ChildItem -Path 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'))
    {
        $props = $item | Get-ItemProperty
        if ($($props.DisplayName -notlike ''))
        {
            if ([bool]$($props.WindowsInstaller)) { [System.Guid]$productCode = $($item.PSChildName) } else { $productCode =[System.Guid]::Empty }
            $applications += New-Object PSObject -Property @{	RegistryPath = $($item.Name)
                                                                Version = $($props.DisplayVersion)
                                                                HelpLink = $($props.HelpLink)
                                                                ModifyCommand = $($props.ModifyPath)
                                                                Vendor = $($props.Publisher)
                                                                UninstallCommand = $($props.UninstallString)
                                                                IsWindowsInstaller = [bool]$($props.WindowsInstaller)
                                                                Name = $($props.DisplayName)
                                                                MoreInfoLink = $($props.MoreInfoURL)
                                                                AboutLink = $($props.URLInfoAbout)
                                                                ParentKey = $($props.ParentKeyName)
                                                                ParentName = $($props.ParentDisplayName)
                                                                ProductCode = $productCode
                                                                Architecture = 'x86' }
        }
    }

    Write-Output $applications
}