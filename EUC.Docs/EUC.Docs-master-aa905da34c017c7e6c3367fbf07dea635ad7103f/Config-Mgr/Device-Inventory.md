## Device Inventory
### Drivers
By default ConfigMgr does not inventory driver versions from `Win32_PnPSignedDriver`. In addition, when this WMI class is added it is not a valid WMI class as the PrimaryKey column does not contain any data.

A custom WMI class called `Win32_PnPSignedDriver_Custom` is created on all Windows 10 PC's via a ConfigMgr package. This package executes a PowerShell script that adds the WMI class and populates it with information from the `Win32_PnPSignedDriver` class. At the time of writing the package source can be found at `\\m562prd1\src$\CM_Managed\Apps\Tier1\BCCCustomWMIClasses_1.0.0.0\Distribution\x64\REV01`.

The package is advertised to run weekly to ensure the driver version details are kept up to date.

#### Client Policies
The hardware inventory settings for the policy *BCC Device Settings* have been modified to include the `Win32_PnPSignedDriver_Custom` WMI class.

#### Source

~~~~ powershell
function New-CustomDriverClass
{
  [CmdletBinding()]
  [Alias()]
  [OutputType([int])]
  Param
  (
  )

  process {
    $class = New-Object System.Management.ManagementClass('root\cimv2', [String]::Empty, $null); 

    $class['__CLASS'] = 'Win32_PnPSignedDriver_Custom'; 

    $class.Qualifiers.Add('Static', $true)
    $class.Properties.Add('DeviceID', [System.Management.CimType]::String, $false)
    $class.Properties['DeviceID'].Qualifiers.Add('key', $true)
    $class.Properties['DeviceID'].Qualifiers.Add('read', $true)

    $class.Properties.Add('DriverProviderName', [System.Management.CimType]::String, $false)
    $class.Properties['DriverProviderName'].Qualifiers.Add('read', $true)
    $class.Properties.Add('DriverVersion', [System.Management.CimType]::String, $false)
    $class.Properties['DriverVersion'].Qualifiers.Add('read', $true)
    $class.Properties.Add('DeviceName', [System.Management.CimType]::String, $false)
    $class.Properties['DeviceName'].Qualifiers.Add('read', $true)
    $class.Properties.Add('Manufacturer', [System.Management.CimType]::String, $false)
    $class.Properties['Manufacturer'].Qualifiers.Add('read', $true)
    $class.Put()
  }
}
function Update-CustomDriverClass
{
  [CmdletBinding()]
  [Alias()]
  [OutputType([int])]
  Param
  (
  )

  begin {
    $drivers = Get-WmiObject Win32_PnPSignedDriver
    $copyOfDrivers = Get-WmiObject Win32_PnPSignedDriver_Custom
  }

  process {
    
    # update the Win32_PnPSignedDriver_Custom with new or changed instances
    foreach ($driver in $drivers) {

      # does the driver exist in the current Win32_PnPSignedDriver_Custom class
      if ($copyOfDrivers | ? { $_.DeviceID -like "$($driver.DeviceID)" }) {

        # check if instance is the same
        if (Compare-Object -ReferenceObject $driver -DifferenceObject ($copyOfDrivers | ? { $_.DeviceID -like $($driver.DeviceID) }) -Property DeviceName, DriverVersion, Manufacturer -PassThru) {
          Write-Verbose "Instance $($driver.DeviceID) exists and properties do not match. Re-creating instance"
            
          Get-WmiObject Win32_PnPSignedDriver_Custom | ? { $_.DeviceID -like "$($driver.DeviceID)" } | Remove-WmiObject
          Set-WmiInstance -Path \\.\root\cimv2:Win32_PnPSignedDriver_Custom -Arguments @{DeviceID=$($driver.DeviceID);DriverProviderName=$($driver.DriverProviderName);DriverVersion=$($driver.DriverVersion);Manufacturer=$($driver.Manufacturer);DeviceName=$($driver.DeviceName);}
        } else {
          Write-Verbose "Instance $($driver.DeviceID) exists and properties match"
        }
      } else {
        Write-Verbose "Creating new instance $($driver.DeviceID)"
        Set-WmiInstance -Path \\.\root\cimv2:Win32_PnPSignedDriver_Custom -Arguments @{DeviceID=$($driver.DeviceID);DriverProviderName=$($driver.DriverProviderName);DriverVersion=$($driver.DriverVersion);Manufacturer=$($driver.Manufacturer);DeviceName=$($driver.DeviceName);}
      }
    }

    # remove any Win32_PnPSignedDriver_Custom instances not found on the local PC anymore
    foreach ($driverCopy in $copyOfDrivers) {
      if (-not ($drivers | ? { $_.DeviceID -like "$($driverCopy.DeviceID)" })) {
        Write-Verbose "Instance $($driverCopy.DeviceID) does not exist in the current driver instance and will be removed"
        Get-WmiObject Win32_PnPSignedDriver_Custom | ? { $_.DeviceID -like "$($driverCopy.DeviceID)" } | Remove-WmiObject
      }
    }
  }
}

if (-not $(Get-WmiObject Win32_PnPSignedDriver_Custom -ErrorAction SilentlyContinue)) {
  New-CustomDriverClass
}

Update-CustomDriverClass
~~~~
