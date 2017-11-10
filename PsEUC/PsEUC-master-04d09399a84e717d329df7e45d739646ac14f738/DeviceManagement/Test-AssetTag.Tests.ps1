$thisScript = Split-Path -Parent $MyInvocation.MyCommand.Path
$scriptUnderTest = (Split-Path -Leaf $MyInvocation.MyCommand.Path).Replace(".Tests.", ".")
. "$thisScript\$scriptUnderTest"

Describe 'Test-AssetTag Tests' {
    Context 'Should return true' {
        It 'Valid PC' { 
             Test-AssetTag -AssetTag 'D123456' | Should Be $true
        }

        It 'Valid laptop/notebook' { 
             Test-AssetTag -AssetTag 'N123456' | Should Be $true
        }

        It 'Valid PC (lowercase)' { 
             Test-AssetTag -AssetTag 'd123456' | Should Be $true
        }

        It 'Valid laptop/notebook (lowercase)' { 
             Test-AssetTag -AssetTag 'n123456' | Should Be $true
        }
    }
    Context 'Should return false' {
        It 'Too many numbers' { 
             Test-AssetTag -AssetTag 'D1234567' | Should Be $false
        }

        It 'Not enough numbers' { 
             Test-AssetTag -AssetTag 'D12345' | Should Be $false
        }

        It 'No leading character' { 
             Test-AssetTag -AssetTag '123456' | Should Be $false
        }

        It 'Incorrect leading character' { 
             Test-AssetTag -AssetTag 'F123456' | Should Be $false
        }

        It 'O intead of 0' { 
             Test-AssetTag -AssetTag 'DO23456' | Should Be $false
        }

        It 'Empty tag' { 
             Test-AssetTag -AssetTag '' | Should Be $false
        }

        It 'Hyper-V default tag' { 
             Test-AssetTag -AssetTag 'To Be Filled By O.E.M.' | Should Be $false
        }

        It 'Tag with space' { 
             Test-AssetTag -AssetTag 'D12 456' | Should Be $false
        }
    }
}