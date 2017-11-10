## Driver Deployment
### Overview
Using the driver functionality has left a bad taste in my mouth with a number of issues experienced. Deployments are also done with the Microsoft Deployment Toolkit which has some limitations around driver deployment, so the instructions presented below create a standalone executable package that can be silently installed to import all the drivers. In addition, by importing all the drivers, hardware that hasn't been connected yet can be added at a later date and the drivers will be available for installation without having to run another package.

At a high level, the executable package works by:

1. decompressing the contents of the package to a temp folder on the PC
1. runs `dpinst.exe` against the root of the temp folder
1. in the root folder is a file named `dpinst.xml` which includes all the subfolders in the package
1. `dpinst.exe` proceeds to import each driver in to Windows
1. after `dpinst.exe` has completed, the temp folder is removed
1. Windows will detect that additional drivers are now available, and will begin to assign them to the appropriate hardware devices

Some drivers are still imported in to Config Mgr for boot critical reasons (notably network and storage).

### Boot Critical Drivers

\\m562prd1\src$\CM_Managed\Drivers\Boot-Criticalcopy winpe


### Driver Packs
#### Requirements

* [Inno Setup](http://www.jrsoftware.org/isinfo.php)
* [PsEUC cmdlets](https://gitlab.com/bccisb/PsEUC)
* technical proficiency using Config Mgr

#### Work Instructions
##### Creating the Package

1. download the drivers from the vendor's website

  * [HP](http://ftp.hp.com/pub/caps-softpaq/cmit/HP_Driverpack_Matrix_x64.html)
  * [Dell](http://en.community.dell.com/techcenter/enterprise-client/w/wiki/2065.dell-command-deploy-driver-packs-for-enterprise-client-os-deployment)
  * [Microsoft Surface Pro 3](https://www.microsoft.com/en-au/download/details.aspx?id=38826)
  * [Microsoft Surface Pro 4](https://www.microsoft.com/en-us/download/details.aspx?id=49498)
  * [Microsoft Surface 3 and Surface 3 LTE](https://www.microsoft.com/en-us/download/details.aspx?id=49041)
  
2. extract all of the drivers to a folder on the local system (please note only .inf based drivers are supported). The end result should look something like this:

~~~~
model
  └ audio
     └ driverfile.dll
     └ driverfile.inf
  └ video
     └ ...
  └ network
     └ ...
  └ ...

~~~~

3. open a PowerShell console and run `import-module \\m562prd1\psmodules$\pseuc`
1. run the cmdlet `New-EUCCMDriverPackage` to generate an exectuable package that contains all the compressed drivers. For example : `New-EUCCMDriverPackage -Path 'C:\temp\E5550_5550-win10-A02-PHJF6\E5550_5550\win10\x64' -Vendor Dell -Model "Latitude E5550" -OperatingSystem Windows-10 -Architecture x64 -PublishedDate 2016-04-15`
1. as part of this cmdlet, a `dpinst.xml` file is created with the file structure, and `dpinst.exe` is included in the executable package
1. a file will be created under `c:\temp` under a folder with the driver name. For example, the above example would be output to `c:\temp\Dell.Latitude-E5550.Windows-10.x64.2016-04-15\Dell.Latitude-E5550.Windows-10.x64.2016-04-15.exe`
1. copy this folder to the `\\m562prd1\src$\CM_Managed\Apps\DriverPacks` folder

##### Package for Config Mgr

1. under *Software Library → Application Management → Packages → MOEvNext → Driver Packs* create a new package. Use the published date of the package for the version number
1. add `/verysilent /norestart` as arguments to the executable. For example `Lenovo.ThinkCentre-M900.Windows-10.x64.2015-11-18.exe /verysilent /norestart`
1. distribute the package as you normally would

##### Task Sequence Modifications

1. make a copy of the current *MOE - Windows 10 (n.n.n)* task sequence and move to the *_Superseded* folder
1. update the version of the current *MOE - Windows 10 (n.n.n)* task sequence. As an example `10.89.0+osd.2016-05-16` would be updated to `10.90.0+osd.2016-05-17`
1. edit the same task sequence and add an additional step under *Packaged Drivers*. Copy an existing step as a starting point
1. update the condition of the step with the correct hardware strings. The condition should be of type *WMI* and will look similar to the following `SELECT * FROM Win32_ComputerSystem WHERE Manufacturer LIKE 'LENOVO' AND SystemFamily = 'ThinkCentre M900'`
1. to find the correct hardware strings, a good tip is to:
    1. boot the hardware using the Config Mgr boot disk
    1. press *F8* to open a command prompt
    1. run `powershell`
    1. type the command `get-wmiobject win32_computersystem`
    1. use the model and manufacturer properties
