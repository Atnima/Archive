
function Get-CMFolder
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, Position=0)]
        [string]$Name
    )

    Begin {
        $Name = $Name.Replace('*', '%')
    }

    Process {
        if ($Name) {
            Invoke-CMWmiQuery -Query "SELECT * FROM SMS_ObjectContainerNode ocn WHERE ocn.ObjectType = '6000' AND ocn.Name LIKE '$Name'"
        } else {
            Invoke-CMWmiQuery -Query "SELECT * FROM SMS_ObjectContainerNode ocn WHERE ocn.ObjectType = '6000'"
        }
    }
}

<#
    SmsProviderObjectPath
    ContainerNodeID
    FolderFlags
    FolderGuid
    IsEmpty
    Name
    ObjectType
    ObjectTypeName
    ParentContainerNodeID
    SearchFolder
    SearchString
    SourceSite
#>