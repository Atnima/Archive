$here = Split-Path -Parent $MyInvocation.MyCommand.Path
. "$here\Get-DateInFutureByDays.ps1"

# set the date to a known date; in this case Friday, 7 August 2015 10:00:00 AM
$TEST_DATE = '2015-08-07 10:00:00'

Describe 'Get-DateInFutureByDays Tests' {
    Context 'Only Work Days' {
        It 'Should skip Saturday and Sunday' {
            $(Get-DateInFutureByDays -Time $TEST_DATE -Days 1 -WorkWeekOnly) -eq '2015-08-10 10:00:00' | Should be $true
        }

        It 'Should skip Sunday' { 
             $(Get-DateInFutureByDays -Time $TEST_DATE -Days 2 -WorkWeekOnly) -eq '2015-08-10 10:00:00' | Should be $true
        }

        It 'No skipping' { 
             $(Get-DateInFutureByDays -Time $TEST_DATE -Days 3 -WorkWeekOnly) -eq '2015-08-10 10:00:00' | Should be $true
        }
    }

    Context 'Any Day' {
        It 'No skipping Saturday' {
            $(Get-DateInFutureByDays -Time $TEST_DATE -Days 1) -eq '2015-08-08 10:00:00' | Should be $true
        }

        It 'No skipping Sunday' { 
             $(Get-DateInFutureByDays -Time $TEST_DATE -Days 2) -eq '2015-08-09 10:00:00' | Should be $true
        }

        It 'No skipping' { 
             $(Get-DateInFutureByDays -Time $TEST_DATE -Days 3) -eq '2015-08-10 10:00:00' | Should be $true
        }
    }
}
