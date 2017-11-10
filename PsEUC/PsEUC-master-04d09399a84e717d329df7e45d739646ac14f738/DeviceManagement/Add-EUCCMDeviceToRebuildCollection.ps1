


function Add-EUCCMDeviceToRebuildCollection
{
    [CmdletBinding()]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        $ComputerName
    )
    
    $rebuildCollection = 'KA100011' # BCC MOEvNext - OSD Rebuild
    $functionResult = $false

    $currentLocation = Get-Location
    Set-Location 'KA1:'
    
    $device = Get-CMDevice -Name $ComputerName

    if ($device) {
        try {
            Add-CMDeviceCollectionDirectMembershipRule -CollectionId $rebuildCollection -ResourceId $($device.ResourceId)
            $functionResult =  $true
        } catch {
            $functionResult =  $false    
        }
    } else {
        $functionResult =  $false
    }

    Set-Location $currentLocation
    Write-Output $functionResult
}


