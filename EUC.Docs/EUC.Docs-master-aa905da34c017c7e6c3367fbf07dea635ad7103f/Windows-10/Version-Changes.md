
Operating System | Source Image | Reference Image | OS Deployment
--- | --- | --- | ---
Windows 8.1 | 2.1.0+source.2015-07-07 | 2.10.0+refimage.2015-05-14 | 2.12.0+osd.2015-05-14
Windows 10 | 10.2.1+source.2015-08-31 | 10.3.0+refimage.2015-08-31 | 10.10.0+osd.2015-08-31

# Image Description
* Source = Vanilla Windows installation, generally with .Net included and patched
* Reference Image = Uses the source image and adds applications not updated frequently, such as the VC++ Runtimes
* OS Deployment = Uses the reference image to create an OS deployment. An image is not captured

# Windows 10 x86
## Source Image
### 9.0.0+source.2015-09-21
* initial source image

# Windows 10 x64
## Source Image with Patches
### 10.0.1+patched-source.2015-10-01
* added 3081452, 3087040, 3095020

## Source Image
### 10.0.0+source.2015-08-01
* initial source image

### 10.1.0+source.2015-08-04
* updated OS to volume license edition

### 10.2.0+source.2015-08-20
* updated with latest patches

### 10.2.1+source.2015-08-31
* updated with latest patches

### 10.2.2+source.2015-09-09
* updated with latest patches

## Reference Image
### 10.0.0+refimage.2015-08-04
* initial reference image

### 10.1.0+refimage.2015-08-19
* removed Adobe Reader from build for App-V testing

### 10.2.0+refimage.2015-08-20
* removed Trim from build for App-V testing

### 10.3.0+refimage.2015-08-31
* removed App-V 4.6 SP3 as it is no longer supported by Microsoft
* updated `Google Legacy Browser Support` to 4.0.0.0
* added Trim back in to the base build :(

### 10.3.1+refimage.2015-09-01
* previous version of WIM corrupted

### 10.4.0+refimage.2015-09-10
* added Adobe Reader back in to the base build :(
* updated to 10.2.2+source.2015-09-09 as the install OS

## OS Deployment
### 10.0.0+osd.2015-08-05
* inital task sequence, copied from 2.12.0

### 10.1.0 to 10.9.0
* tinkering

### 10.10.0+osd.2015-08-31
* updated WIM image to `10.3.0+refimage.2015-08-31`
* removed Trim as installed App-V application

### 10.81.0+osd.2016-04-13
* updated Chrome installer to use a proxy to download the latest installer. This works because command line apps don't require authentication through the proxy
* updated MOEvNext Assets to 1.22.0.0. This package removes wallpapers
* added MOEvNext Assets - Wallpapers 1.0.0.0 with "ADDLOCAL=StandardWallpaper"

# Windows 2008 R2 Server with IE 8
## Source Image
### 5.0.0+source.2015-08-12
* initial task sequence

### 5.1.0+source.2015-09-08
* initial task sequence

### 5.2.0+source.2015-09-08

# Windows 2008 R2 Server with IE 9
## Source Image
### 6.0.0+source.2015-08-12
* initial task sequence

# Windows 2008 R2 Server with IE 10
## Source Image
### 7.0.0+source.2015-08-12
* initial task sequence

# Windows 2012 R2 Server
## Source Image
### 8.0.0+source.2015-08-12
* initial task sequence

### 8.0.1+source.2015-09-10
* updated with September 2015 security patches

## Reference Image
### 8.0.0+refimage.2015-08-14
* initial task sequence

# Windows 8.1 MOE
## Source Image
### 2.0.0+source.2014-12-09
* initial reference image
* security patches and updates up to December 2014

### 2.0.1+source.2014-12-16
* added step to cleanup WIM

### 2.0.2+source.2015-02-12
* updated with February 2015 security patches

### 2.0.3+source.2015-03-12
* updated with March 2015 security patches
 
### 2.0.4+source.2015-04-09
* updated with April 2015 security patches

### 2.0.5+source.2015-04-16
* updated with April 2015 security patches
* not all updates install in previous image

### 2.0.6+source.2015-05-14
* updated with May 2015 security patches

### 2.0.7+source.2015-06-11
* updated with June 2015 security patches

### 2.1.0+source.2015-07-07
* update source WIM to include update 1 only; updates 2 and 3 have been superseded

### 2.2.0+source.2015-08-12
* moved Visual C++ redistributables into source image
* remove .Net Framework 4.5.2
* added .Net Framework 4.6

### 2.2.1+source.2015-09-10
* updated with latest security patches

## Reference Image
### 2.0.0+refimage.2014-10-23
* initial reference image

### 2.1.0+refimage.2014-11-04
* removed Citrix Receiver 14.2.1
* added all Visual C++ Redistributables as almost all of them were being installed for other applications

### 2.2.0+refimage.2014-11-04
* added .Net Framework 4.5.2

### 2.3.0+refimage.2014-11-10
* updated EMET 5.0 to 5.1
* added November 2014 security patches
* added November 2014 update rollup (KB3000850)
* added sysprep cleanup script
* changed from imagex to dism for image capture

### 2.4.0+refimage.2014-12-08
* updated to App-V 5.0 SP3
* updated to UE-V 2.1
* copied `Windows 8.1 Enterprise x64 (6.3.9600.17056) 2014-10-15` WIM and replaced as deployed operating system
* added KB2975719 and KB3000850 to copied WIM
* moved .Net Framework 4.5.2 to source image

### 2.4.1+refimage.2014-12-12
* changed installed operating system to 2.0.0+source.2014-12-09

### 2.4.2+refimage.2014-12-17
* changed installed operating system to 2.0.1+source.2014-12-16
* fixed UE-V installation command

### 2.5.0+refimage.2015-02-13
* changed installed operating system to 2.0.2+source.2015-12-02
* added Citrix to reference image

### 2.5.1+refimage.2015-03-12
* changed installed operating system to 2.0.3+source.2015-03-12

### 2.6.0+refimage.2015-03-13
* updated EMET to version 5.2

### 2.7.0+refimage.2015-03-17
* added Office 365 Pro Plus

### 2.8.0+refimage.2015-04-10
* changed installed operating system to 2.0.4+source.2015-04-09

### 2.9.0+refimage.2015-04-10
* changed installed operating system to 2.0.5+source.2015-04-16
* updated Office 365 Pro Plus source
* removed BCC specific apps back in to deploy not capture

### 2.10.0+refimage.2015-05-14
* changed installed operating system to 2.0.6+source.2015-05-14
* updated Chrome
* updated Adobe Reader to 11.0.11
* added Chrome Legacy Browser support

### 2.10.1+refimage.2015-06-11
* changed installed operating system to 2.0.7+source.2015-06-11

### 2.11.0+refimage.2015-08-14
* removed App-V 4.6 SP3 Hotfix 2
* added App-V 4.6 SP3 Hotfix 3
* added App-V 5.0 SP3 Hotfix 2
* removed Citrix Receiver 4.2
* added Citrix Receiver 4.3
* removed Adobe Reader XI 11.0.11
* added Adobe Acrobat Reader DC Adobe Reader DC 15.008.20082

### 2.12.0+refimage.2015-08-17
* corrected issue with Trim not installing

### 2.14.0+refimage.2015-09-10
* remove App-V 5.0 SP3 Hotfix 2
* added App-V 5.1
* removed Google Legacy Browser 3.3.0.0
* added Google Legacy Browser 4.0.0.0
* changed installed operating system to 2.2.1+source.2015-09-10

## OS Deployment
### 2.0.0+osd.2014-10-23
* inital task sequence

### 2.0.1+osd.2014-10-30
* minor tweaks

### 2.1.0+osd.2014-11-04
* cleaned up task sequence to remove all tasks related to refresh or replacement devices

### 2.2.0+osd.2014-11-05
* added Google Chrome

### 2.3.0+osd.2014-11-06
* added post installation script

### 2.4.0+osd.2014-11-07
* added first run script (per user, for migration activities)
* updated post installation script
  * set start screen
  * update Powershell help files
  * set power plan for Surface Pro 3
* added KB2955769 to apply during WIM deployment
* added Adobe Reader XI app-v
* updated OU computer is joined to
* added Citrix Receiver app-v

### 2.5.0+osd.2014-11-21
* updated reference image to 2.3.0+refimage.2014-11-10
* added Kapish tools, including compatible version of EasyLink
* updated UE-V templates

### 2.6.0+osd.2014-12-08
* updated post build script to generate random admin password

### 2.7.0+osd.2015-01-13
* updated versions of the Trim and Kapish packages to resolve several defects
* Citrix is now natively installed, not virtualised
* added Microsoft boot xray

### 2.8.0+osd.2015-01-19
* updated Start Screen layout
* added support for Dell Venue 7140
* updated Dell Venue 7130 to also work with a Dell Venue 7139
* updated installation of Citrix client to remove USB (hardware passthrough) support. This was causing "HDX" errors

### 2.9.0+osd.2015-02-09
* added

### 2.9.1+osd.2015-03-13
* installs off 2.7.0+refimage.2015-03-17
 
### 2.10.0+osd.2015-03-25
* updated `IE Configuration` and `MOEvNExt Assets` packages

### 2.11.0+osd.2015-04-09
* migrated task sequence to `m562prd1`

### 2.12.0+osd.2015-05-14
* updated OS WIM to 2.10.0+refimage.2015-05-14
* updated BCC IE Configuration

### 2.14.0+osd.2015-08-05
* updated OS WIM to 2.10.0+refimage.2015-05-14

