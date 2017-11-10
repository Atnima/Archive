## Configuration Baselines
### Compliance Rules
#### Records Manager Sync Issue
This compliance rule turns off RM8 from generating a log file for the Outlook Addin. Because this file is saved to the *Documents* folder, it often causes a synchronisation issue with Citrix.

~~~~ powershell
# detection script
[xml]$shouldBeContent = @'
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <assemblyIdentity name="HP.HPTRIM.Outlook.Addin, PublicKeyToken=93ab772ef8ad9a2e1" />
  <loaderSettings generateLogFile="false" shadowCopyEnabled="true" privileges="administrator" configFileName="app.config" />
</configuration>
'@

try {
    [xml]$contentOfConfig = Get-Content 'C:\Program Files\Hewlett Packard Enterprise\Records Manager\adxloader.dll.manifest' -Raw
    if (Compare-Object -ReferenceObject $shouldBeContent -DifferenceObject $contentOfConfig -Property InnerXml) {
        return $false
    } else {
        return $true
    }
} catch {
    return $false
}
~~~~


~~~~ powershell
# remeditation script
$shouldBeContent = @'
<?xml version="1.0" encoding="utf-8"?>
<configuration>
  <assemblyIdentity name="HP.HPTRIM.Outlook.Addin, PublicKeyToken=93ab772ef8ad9a2e1" />
  <loaderSettings generateLogFile="false" shadowCopyEnabled="true" privileges="administrator" configFileName="app.config" />
</configuration>
'@

try {
    Set-Content -Path 'C:\Program Files\Hewlett Packard Enterprise\Records Manager\adxloader.dll.manifest' -Value $shouldBeContent -PassThru

    $shouldBeContent | Out-File -Path 'C:\Program Files\Hewlett Packard Enterprise\Records Manager\adxloader.dll.manifest'
} catch {
    return $false
}
~~~~