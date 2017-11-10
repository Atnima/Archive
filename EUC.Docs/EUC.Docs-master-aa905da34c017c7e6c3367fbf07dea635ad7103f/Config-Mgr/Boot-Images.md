## Boot Images

### PXE Boot
* m562prd1
* standalone wds
* modified wim's (see example here https://micloud.azurewebsites.net/using-wds-to-deploy-sccm-images-without-pxe-enabled-dps/?_sm_au_=iVVSL2VNPGkL2SPq)

~~~~
Mount-WindowsImage -ImagePath .\2007\SOURCES\BOOT.WIM -Path .\sccm-winpe\ -Index 1
robocopy .\2007\SMS\ .\sccm-winpe\SMS * /s /e
Dismount-WindowsImage -Path .\sccm-winpe\ -Save


Mount-WindowsImage -ImagePath .\2012\SOURCES\BOOT.WIM -Path .\cm-winpe\ -Index 1
robocopy .\2012\SMS\ .\cm-winpe\SMS * /s /e
Dismount-WindowsImage -Path .\cm-winpe\ -Save
~~~~

### Boot Media
TODO
http://deploymentresearch.com/Research/Post/528/Fixing-the-ldquo-Failed-to-find-a-valid-network-adapter-rdquo-error-in-ConfigMgr-Current-Branch
