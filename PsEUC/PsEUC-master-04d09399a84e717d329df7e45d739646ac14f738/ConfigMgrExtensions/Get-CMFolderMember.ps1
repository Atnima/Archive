
function Get-CMFolderMember
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true)]
        [int]$ContainerId
    )

    Begin {
        #$Name = $Name.Replace('*', '%')
    }

    Process {
        $appsToReturn = @()
        $count = 0
        $folderItems = Invoke-CMWmiQuery -Query "SELECT * FROM SMS_ObjectContainerItem WHERE ContainerNodeID = '$ContainerId'"
        foreach ($item in $folderItems) {
            $appsToReturn += Get-CMApplication -ModelName $($item.InstanceKey) -Fast
        }

        Write-Output $appsToReturn
    }
}

