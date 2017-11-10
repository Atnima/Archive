function New-Guid
{
    <#
    .SYNOPSIS
    Generate a new GUID
    .DESCRIPTION
    Generate a new GUID with or without dashes
    .LINK
    None
    #>

    [CmdletBinding()]
    param
    (
        [Switch]$NoDash = $false,
        [int]$Count = 1
    )

    process
    {
      for ($i = 0; $i -lt $Count; $i++)
      {
        if ($NoDash -eq $false)
        {
          Write-Output $([System.Guid]::NewGuid())
        }
        else
        {
          Write-Output $([System.Guid]::NewGuid().ToString().Replace('-', ''))
        }
	    }
    }
}