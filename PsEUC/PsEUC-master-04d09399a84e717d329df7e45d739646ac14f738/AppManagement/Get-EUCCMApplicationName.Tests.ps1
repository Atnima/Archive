$thisScript = Split-Path -Parent $MyInvocation.MyCommand.Path
$scriptUnderTest = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace('.Tests.', '.')
. "$thisScript\$scriptUnderTest"

Describe 'Get-EUCCMApplicationName Tests' {
    Context 'Name Examples' {
        It 'Application name with no unusual characters' { 

            $appName = Get-EUCCMApplicationName -Vendor 'Microsoft' -Name 'Power BI Desktop' -Version '2.23.1.33'
            $appName.LongName | should be 'Microsoft Power BI Desktop 2.23.1.33'
        }

        It 'Application short name with no unusual characters' { 

            $appName = Get-EUCCMApplicationName -Vendor 'Microsoft' -Name 'Power BI Desktop' -Version '2.23.1.33'
            $appName.ShortName | should be 'MicrosoftPowerBIDesktop_2.23.1.33'
        }

        It 'Application short name with brackets' { 
            $appName = Get-EUCCMApplicationName -Vendor 'Microsoft' -Name 'Power BI Desktop (x64)' -Version '2.23.1.33'
            $appName.ShortName | should be 'MicrosoftPowerBIDesktopx64_2.23.1.33'
        }

        It 'Application short name with dashes' { 
            $appName = Get-EUCCMApplicationName -Vendor 'Microsoft' -Name 'Power BI Desktop - x64' -Version '2.23.1.33'
            $appName.ShortName | should be 'MicrosoftPowerBIDesktopx64_2.23.1.33'
        }

        It 'Application short name with full stops' { 

            $appName = Get-EUCCMApplicationName -Vendor 'Microsoft.Research' -Name 'Power BI Desktop' -Version '2.23.1.33'
            $appName.ShortName | should be 'MicrosoftResearchPowerBIDesktop_2.23.1.33'
        }
        }
}