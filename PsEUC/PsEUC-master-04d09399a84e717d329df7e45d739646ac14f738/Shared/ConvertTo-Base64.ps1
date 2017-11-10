<#
    .SYNOPSIS
    Convert plain text in to Base64 encoded text
#>
function ConvertTo-Base64
{
    [CmdletBinding()]
    [OutputType([string])]
    param
    (
        [parameter(Position=0, Mandatory=$true)]
        [string]$Text
    )

    $bytes = [System.Text.Encoding]::UTF8.GetBytes($Text)
    Write-Output "$([System.Convert]::ToBase64String($bytes))"
}
