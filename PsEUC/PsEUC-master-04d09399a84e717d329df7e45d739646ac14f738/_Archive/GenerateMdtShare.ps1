<#
$mdtDrive = 'DS002:'

Set-Location "$mdtDrive\\Operating Systems"
New-Item -Path . -ItemType Folder -Name 'Source'
New-Item -Path . -ItemType Folder -Name 'Captures'

Set-Location "$mdtDrive\\Task Sequences"
New-Item -Path . -ItemType Folder -Name 'Admin'
New-Item -Path . -ItemType Folder -Name 'Test'
New-Item -Path . -ItemType Folder -Name 'Deploy'
Set-Location "$mdtDrive\\Task Sequences\Admin"
New-Item -Path . -ItemType Folder -Name 'Reference Images'
New-Item -Path . -ItemType Folder -Name 'OOBE'

Set-Location "$mdtDrive\\Applications"
New-Item -Path . -ItemType Folder -Name '_SUPERSEDED'
New-Item -Path . -ItemType Folder -Name 'Current'



$apps = Import-Csv C:\temp\apps-tier1.csv
foreach ($app in $apps)
{
    New-Item -ItemType Application -Name $($app.Name) -DisplayName $($app.Name) -ShortName $($app.ShortName) -Version $($app.Version) -CommandLine $($app.CommandLine) -WorkingDirectory $($app.WorkingDirectory) -Publisher $($app.Publisher) 
}
#>