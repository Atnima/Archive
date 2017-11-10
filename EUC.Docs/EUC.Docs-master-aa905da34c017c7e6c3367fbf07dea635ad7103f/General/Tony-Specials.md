
    "We ask not why, we just fix" - Everybody

# Move Plans
* scheduled task running on `m490prd1` to copy files from the server to several thin clients : `E:\Scripts\MovePlans.bat`
* `schtasks.exe /query /tn "move plans"`
* the task scheduleder mmc console is broken on `m490prd1`

## Recent Changes
* updated script to include credentials as someone ****cough cough**** recently had a password change
* updated scheduled task to use non-domain credentials `schtasks.exe /change /tn "move plans" /ru "NT AUTHORITY\LOCALSERVICE"`
