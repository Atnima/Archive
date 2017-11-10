
<#
.Synopsis
   Short description
.DESCRIPTION
   Long description
.EXAMPLE
   Example of how to use this cmdlet
.EXAMPLE
   Another example of how to use this cmdlet
#>
function Install-AppvClientPackage
{
    [CmdletBinding()]
    [OutputType([int])]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)]
        [switch]$NotGlobal,
        [switch]$Mount
    )

    Begin
    {
    }
    Process
    {
    	Import-Module 'C:\Program Files\Microsoft Application Virtualization\Client\AppvClient\AppvClient.psd1'

$appvFile = Get-ChildItem -Path $PSScriptRoot -Include *.appv -File -Recurse

$deploymentConfigFile = Get-ChildItem -Path $PSScriptRoot -Include *DeploymentConfig.xml -File -Recurse

Add-AppvClientPackage -Path "$($appvFile.FullName)" -DynamicDeploymentConfiguration "$($deploymentConfigFile.FullName)" | Publish-AppvClientPackage -Global | Mount-AppvClientPackage

 
    }
    End
    {
    }
}
