## Deployments

### Operating System
A device can be re-imaged with Windows 10 by using the following instructions

1. perform a network boot of the device. When prompted, press **Enter** to start booting in to the PXE environment
    * for *Surface* devices, hold down volume down and the power button at the same time
    * for *Venue* devices, press F12 to select a boot device
    * if you are at a site without access to the network PXE server, the Onsite team can provide bootable USB devices
1. a cutdown Windows environment called *WinPE* will boot up, and the Configuration Manager wizards will begin. Initially the device will be added to the rebuild group automatically, and then the current Windows 10 MOE image will be assigned as *required* deployment

This process can take approx. 20 minutes on most hardware. Surface 3 devices which have a slower hard disk can take up to 35 minutes.

### Applications
Applications may be assigned to users or devices, depending on the licensing agreement for the application. Assignments may be done through Active Directory groups. To find the correct Active Directory, you can search for it in the `Active Directory User and Groups` console, or refer to [CA16/901546 DSI - Packaged apps as at 1 November 2016](trim://CA16%2f901546/?db=C1&view).

To assign a user or device to an Active Directory group:

1. search for the group in the `Active Directory User and Groups` console
1. open the group; take note of whether the group is for users or devices which is indicated at the end of the group name. For example *Tier 2 - SAP SAP GUI for Windows – Users* should contain **user** objects
1.  under the *Members* tab, click *Add*, enter the user or device, and then click *Ok*

It may take up to four hours for the software to install on the client device. Please note for tier 3 applications the user will need to open the *Software Centre* and install the application themselves.
