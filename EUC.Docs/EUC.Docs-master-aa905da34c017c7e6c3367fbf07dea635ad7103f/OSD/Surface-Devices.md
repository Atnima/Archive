## Surface Devices
### Asset Tags
As part of the build process, a new Surface device will prompt you to enter the asset tag for the device.

If you need to change the asset tag for a device, the following instructions can be followed:

1. perform a TFTP boot from the PXE server, but use the `BCC MDT' boot image
1. this will come up with a task sequence selection wizard; press `F8` to bring up a command prompt
1. enter the command `net use \\m562prd1\src$` to make a network connection to this path
1. enter the command `\\m562prd1\src$\CM_Managed\Firmware\Tools\Microsoft\AssetTag.exe -s nnnnnn` replacing *nnnnnn* with the new asset tag
1. reboot the device
