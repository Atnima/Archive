function Test-AssetTag
{
    [CmdletBinding()]
    [OutputType([bool])]
    Param
    (
        [Parameter(Mandatory=$true, Position=0)]
        $AssetTag
    )

    Write-Output $($assetTag -match '([D,N])\d{6}$')
}
