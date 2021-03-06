
# check for installed modules
if (-Not $(Get-Module TabExpansionPlusPlus -ListAvailable))
{
    Write-Warning 'The module _TabExpansion++_ is required for some cmdlets to operate correctly. It could not be found in your profile path or did not load correctly'
}


if (-Not $(Get-Module ConfigurationManager -ListAvailable))
{
    Write-Warning 'The module _ConfigurationManager_ is required for some cmdlets to operate correctly. It could not be found in your profile path or did not load correctly'
}

if (-Not $(Get-Module ActiveDirectory -ListAvailable))
{
    Write-Warning 'The module _ActiveDirectory_ is required for some cmdlets to operate correctly. It could not be found in your profile path or did not load correctly'
}

# import all functions
Get-ChildItem $PSScriptRoot\* -Include *.ps1 -Exclude *.Tests.ps1, *.Helper.ps1 -Recurse | % { . $_.FullName }
