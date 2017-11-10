## Group Policies
Where appropriate policy settings in the *Group Policy Management Console* have had a comment added to them. For *administrative template* settings, this would be in the *comment* field. For *preferences*, this would be in the *Common --> Description* field.

### Common Policies

#### EUC-PRD-C-AppLocker-MOE-X
Implements the AppLocker ruleset for Windows 10. Notably on Windows 10, failure/error events are not forwarded to the Windows Event Collectors as they are on Windows 7. This is being looked at as part of the *Security Improvement Project*. The policy is straightforward but there are some things to note:

* DLL rules are enabled
* MSI and script rules are enabled. An MSI file can still be installed but you need to elevate first

#### EUC-PRD-C-Common-MOE-X
Common computer settings for applications such as Office and Adobe Reader.

* under *preferences* are settings for Adobe Reader XI and DC that aren't included with the template provided by Adobe
* under *preferences* is a setting for Remote Assistance. For whatever reason, the standard GPO setting did not work

#### EUC-PRD-C-Firewall-MOE-X
The local Windows firewall is enabled and configured. Some *domain* location rules exist, and local rules may be added for this location.

Locally created *Private* and *Public* rules are configured not to apply. You may notice these rules appear in the Windows GUI on the local PC, and look to be enabled but this is not the case (see [CA17/58390 DSI - Outcome of local firewall discussion RE private and public firewall rules](trim://CA17%2f58390?db=C1&view) for further details).

#### EUC-PRD-C-GoogleChrome
Includes Google Chrome policy settings. This policy was seperated primarily to ease access to the extension whitelist settings.

#### EUC-PRD-U-Common-MOE-X
Common user settings for applications such as Office and Adobe Reader.

* under *preferences* the registry setting *HP.HPTRIM.Outlook.Addin.AddinModule* forces Outlook to ignore the load time of the RM8 Addin
* under *preferences* the registry setting *DisplayAcceptEULAPrompt* disables the `accept EULA` prompt on opening Office 2016 for the first time

### Other Policies

| Policy | Function |
|---|---|
| EUC-PRD-C-Admins-MOE-X | Configured the local administrator group on the PC to remove any custom entries, and only add the ones specified in the policy |
| EUC-PRD-C-OneDrivePilot | Enables the OneDrive client. This policy uses a security filter to limit the policy to certain PC's |
| EUC-PRD-C-BOBI | Allows SAP Reporting to open in Chrome. This policy uses a security filter to limit the policy to certain PC's |
| EUC-PRD-C-ScmBaseline | Implements the templated policy from the [Microsoft Security Compliance Manager](https://technet.microsoft.com/en-au/solutionaccelerators/cc835245.aspx) tool |
| EUC-PRD-C-SuccessFactorsDesktopShortcut-MOE-X | Delivers a desktop shortcut for SuccessFactors. This was deployed as part of the latest SuccessFactors update, and although not required for Windows 10, the business were keen to present a similar experience on both platforms |
| EUC-PRD-C-Wireless | Provides wireless configuration settings for domain joined devices |
| EUC-PRD-U-RedirectedFolderSettings | Redirects the `Desktop` and `Documents` folder to the users home drive. Originally delivered as a seperate policy as the intention was to not implement this feature; this decision is on hold at the moment so the policy remains in effect |
| EUC-PRD-U-SecurityTabException | Allow the user to view the `Security` tab on folder properties. This policy uses a security filter to limit the policy to certain users |
| EUC-PRD-U-StoreException | Allow the user to access the Windows Store. This policy uses a security filter to limit the policy to certain users |
| EUC-PRD-n-VDI | Custom settings to facilitate using VDI devices |

### Mobile Policies

| Policy | Function |
|---|---|
| EUC-PRD-C-DirectAccessClient | This policy is created and managed by the Direct Access servers and **should not be modified directly**. See [CA15/843295 SD - EUC - Direct Access 2012 R2 Detailed Design - FINAL](trim://CA15%2f843295?db=C1&view) for further information |
| EUC-PRD-C-OfflineFiles-MOE-X | Configures the offline files feature of Windows |

### Brisbane Transport Learning Tablet (BTLT)

#### EUC-PRD-C-BTLT
The Brisbane Transport Learning Tablet is a solution that involves using a standard Windows 10 MOE, however a local user account has been provisioned and it is used to automatically log on to the device. In addition *kiosk* mode has been activated, allowing only SAP (via Internet Explorer) as the user interface.

### Admin Virtual Machines

#### EUC-PRD-C-TVMT
This policy overrides the `EUC-PRD-C-Admins-MOE-X` policy. It uses the same AD groups for membership, however the *Delete all member users* setting is **disabled** so that specific users can be added to the local administrators group. This OU and policy is specifically for short-term Windows 10 virtual machines in which users require admin rights.