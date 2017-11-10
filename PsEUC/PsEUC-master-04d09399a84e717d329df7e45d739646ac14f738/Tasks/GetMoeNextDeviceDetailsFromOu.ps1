

<#
$allWindows8Devices = Get-EUCOUDevices -OU 'OU=PROD,OU=MOENext,OU=Computers,OU=BCC,DC=ad,DC=bcc,DC=qld,DC=gov,DC=au'
$allWindows10Devices = Get-EUCOUDevices -OU 'OU=PRODX,OU=MOENext,OU=Computers,OU=BCC,DC=ad,DC=bcc,DC=qld,DC=gov,DC=au'


$allWindows8Devices | Export-Csv 'c:\temp\DSI - Windows 8 OU Export.csv' -NoTypeInformation
$allWindows10Devices | Export-Csv 'c:\temp\DSI - Windows 10 OU Export.csv' -NoTypeInformation

Set-RmDocument -RecordNumber 'CA16/748379' -FilePath 'c:\temp\DSI - Windows 8 OU Export.csv'
Set-RmDocument -RecordNumber 'CA16/748371' -FilePath 'c:\temp\DSI - Windows 10 OU Export.csv'


#>