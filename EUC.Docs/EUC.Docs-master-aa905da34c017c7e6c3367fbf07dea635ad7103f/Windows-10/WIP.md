
NEXT STEPS

- add new emet advertisement
- add new assets advertisement and remove older assets package
- cleanup 7zip adv



2016-07-04
* promoted OSD 10.99.0+osd.2016-07-04 to rebuild collection
    * added Adobe Reader
    * updated Assets to 1.27.0.0
    * updated EMET Policy to 1.3.0.0
    * updated WinPE_OSD to 1.1.0.0
* removed Adobe Reader adv from All Users colletion
* removed ie config 1.7 adv from collection





2016-30-06
* added latest SP4 and S3 drivers to OSD 10.98.0+osd.2016-06-30

2016-28-06
* rolled back latest SP4 and S3 drivers to OSD 10.97.0+osd.2016-06-28 due to issues during OSD

2016-24-06
* added latest SP4 and S3 drivers to OSD 10.96.0+osd.2016-06-24

2016-23-06
* updated 'bcc device' settings to include App-V hardware inventory WMI classes

2016-06-07
* added two new configuration items to the baseline
* deployed 7zip and Citrix updates to early adopters

2016-05-24 TUESDAY
* updated EMET policy to 1.3.0.0 and deployed to PRODX

2016-05-23 MONDAY
* deplyed may update to approx 32 windows 10 devices
* updated proxy.pac to use dedicated port

2016-05-16 MONDAY
* TS version from 10.85 to 10.87, includes Dell Lat E5550 drivers
* TS (TEST) version from 10.86 to 10.88
* updated assets to 1.26 including new reg key for Adobe Reader updates and mms.cfg file for Adobe Flash updates
* created new CI to check firewall rules and add them if missing

2016-05-13 FRIDAY
* update IE config to version 1.8 and added SAP BI reporting to ent mode list


2016-05-05 THURSDAY
* added new baseline for windows 10
* added ci to disable StartupAppTask scheduled task. this will disable the "disable apps to improve performance" message
* copied BCCMOEvNextOSD_1.6.0.0 as BCCMOEvNextOSD_1.7.0.0
    * updated package to include disabling StartupAppTask scheduled task
    * moved all winpe stuff to created BCCMOEvNextOSDWinPE_1.0.0.0
    * moved Move-AdComputerToCorrectOu.ps1 to BCCMOEvNextOSDADDS_1.0.0.0
* created BCCMOEvNextOSDWinPE_1.0.0.0
* created BCCMOEvNextOSDADDS_1.0.0.0
    * updated script to accept OU
* copied OSD "MOE - Windows 10 (10.85.0)" as "MOE - Windows 10 (10.86.0)"
    * updated TS to use new packages
    * updated move OU step
    


2016-05-04 WEDNESDAY
* copied computer settings from "euc-preprd-x-settings testing" to a new policy "euc-prd-c-common-2"
* copied computer settings from "euc-preprd-c-windows 10" to a new policy "euc-prd-c-common-2"
* test what happens when network access is not available. does createshortcuts.vbs fail? UPDATE : IT DOES
* rebuilt BCCMOEvNextAssets_1.23.0.0 msi with updated vbscript
* updated applocker policy to block exe as publisher rule was "winning"
* created BCCEMET55Policy_1.2.0.0 and added regsvr32 as an emet rule

2016-05-03 TUESDAY
* created ou "legacy" under prodx. moved existing "mobiledevices" to this ou and linked same polices as "prodx" ou. enabled policy blocking
* linked policies to prodx and prodx\mobiledevices ou as per preprodx ou
* copied "euc-prd-u-common" as "euc-prd-u-common-2"
* copied task schedule user preferences from "euc-preprd-x-settings testing" to "euc-prd-u-common-2" and changed to "remove"
* copied start menu and task bar settings from "euc-preprd-x-settings testing" to "euc-prd-u-common-2"
* unlinked "euc-preprd-x-settings testing" from prodx ou
* copied BCCMOEvNextAssets_1.22.0.0 to BCCMOEvNextAssets_1.23.0.0 added custom actions to create scheduled tasks. these are tested and works
* unlinked "EUC-PREPRD-C-RemoveEnvVars" from prodx

