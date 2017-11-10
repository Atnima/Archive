workflow New-EUCMDTRefImageVirtualMachineWorkFlow
{
<#
.Synopsis
   Create MDT reference images
.DESCRIPTION
   This workflow provisions a virtual machine on the specified Hyper-V host, boots the MDT wizard and performs any pre-determined task sequences (as defined in the deploymentsettings.ini file), and de-provisions the virtual machine once it has been shutdown
.EXAMPLE
    New-EUCMDTRefImageVirtualMachineWorkFlow -VirtualMachineHost 'd158423' -Credentials $vmBuildServerCred -VirtualMachineName 'wo7refimage' -VirtualMachineDiskLocation 'D:\Resources' -VirtualMachineMacAddress '0A-15-5d-e7-0d-3d'
#>
    [CmdletBinding()]
    Param
    (
        [string]$VirtualMachineHost,
        [System.Management.Automation.PSCredential]$Credentials,
        [string]$VirtualMachineName,
        [string]$VirtualMachineDiskLocation,
        [string]$VirtualMachineMacAddress,
        [string]$VirtualMachineNetworkSwitchName,
        [string]$VirtualMachineBootDiskIso
    )

    InlineScript {
        $vmBuildServerSession = New-PSSession -ComputerName $Using:VirtualMachineHost -Credential $Using:Credentials -UseSSL -SessionOption (New-PSSessionOption -SkipCACheck -SkipCNCheck) -ConfigurationName hypervremoteadmin

        # create the vm, and start it
        Invoke-Command -Session $vmBuildServerSession -ArgumentList $Using:VirtualMachineName, $Using:VirtualMachineDiskLocation, $Using:VirtualMachineMacAddress, $Using:VirtualMachineNetworkSwitchName, $Using:VirtualMachineBootDiskIso -ScriptBlock {
            param($VmName, $VmDiskLocation, $VmMacAddress, $VmNetworkSwitchName, $VMBootDiskIso)
            # FIX : increased startup RAM to 2GB - helps dism apply/capture WIM on Windows 10
            $vm = New-VM -Name $VmName -MemoryStartupBytes 2147483648 -BootDevice CD -SwitchName "$VmNetworkSwitchName"
            # FIX : # using two vcpu's speeds up capture in MDT considerably
            Set-VM -ProcessorCount 2 -vm $vm
            # a VM needs more the 2GB to install all patches and capture a WIM - using dynamic memory as we can't always guarantee 4GB RAM
            Set-VMMemory -DynamicMemoryEnabled $true -vm $vm
            $disk = New-VHD -Path $VmDiskLocation\$VmName-SYSTEM.vhdx -SizeBytes 127GB
            Add-VMHardDiskDrive -Path $VmDiskLocation\$VmName-SYSTEM.vhdx -ControllerType IDE -ControllerNumber 0 -VM $vm
            $dvdDrive = Get-VMDvdDrive -VM $vm
            Set-VMDvdDrive -VMDvdDrive $dvdDrive
            # use x86 lite touch to build x86 and x64 OSD
            Set-VMDvdDrive -VMDvdDrive $dvdDrive -Path $VmDiskLocation\$VMBootDiskIso
            $netAdapter = Get-VMNetworkAdapter -VM $vm
            Set-VMNetworkAdapter -VMNetworkAdapter $netAdapter -StaticMacAddress $VmMacAddress
            Start-VM -VM $vm
        }

        Remove-PSSession $vmBuildServerSession
    }

    Checkpoint-Workflow

    # wait until the VM is stopped which means it has completed capturing
    InlineScript {
        $vmBuildServerSession = New-PSSession -ComputerName $Using:VirtualMachineHost -Credential $Using:Credentials -UseSSL -SessionOption (New-PSSessionOption -SkipCACheck -SkipCNCheck) -ConfigurationName hypervremoteadmin
        Disconnect-PSSession $vmBuildServerSession
        $vmState = 'Running'
        do
        {
            Start-Sleep -Seconds 60
            Connect-PSSession $vmBuildServerSession
            
            $vmState = Invoke-Command -Session $vmBuildServerSession -ArgumentList $Using:VirtualMachineName -ScriptBlock {
                param($VmName)
                Write-Output $((Get-VM -Name $VmName).State)
            }

            Disconnect-PSSession $vmBuildServerSession

        } while ($vmState -eq 2) # 2 = Running

        Remove-PSSession $vmBuildServerSession
    }

    Checkpoint-Workflow

    # de-provision the VM
    InlineScript {
        $vmBuildServerSession = New-PSSession -ComputerName $Using:VirtualMachineHost -Credential $Using:Credentials -UseSSL -SessionOption (New-PSSessionOption -SkipCACheck -SkipCNCheck) -ConfigurationName hypervremoteadmin

        Invoke-Command -Session $vmBuildServerSession -ArgumentList $Using:VirtualMachineName, $Using:VirtualMachineDiskLocation -ScriptBlock {
            param($VmName, $VmDiskLocation)
            $vm = Get-VM -Name $VmName
            Remove-VM -VM $vm -Force
            Remove-Item -Path $VmDiskLocation\$VmName-SYSTEM.vhdx
        }

        Remove-PSSession $vmBuildServerSession
    }
}
