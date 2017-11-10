<#
    .SYNOPSIS
    Convert Base64 encoded text in to plain text
#>
function ConvertFrom-Base64
{
    [CmdletBinding()]
    [OutputType([string])]
    param
    (
        [Parameter(Position=0, Mandatory=$true)]
        [string]$EncodedText
    )

    $bytes = [System.Convert]::FromBase64String($EncodedText)
    Write-Output "$([System.Text.Encoding]::UTF8.GetString($bytes))"
}
