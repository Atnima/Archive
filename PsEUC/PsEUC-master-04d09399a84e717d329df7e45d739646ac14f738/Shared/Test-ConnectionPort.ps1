<#
.SYNOPSIS
    Open a connection to a TCP port
.DESCRIPTION
    Attempt to open a socket to a TCP port on the specified computer
.EXAMPLE
    Test-TcpConnectionPort -ComputerName mars -Port 443
#>
Function Test-TcpConnectionPort
{
    [CmdletBinding()]
    [OutputType([bool])]
	Param
	(
		[Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$ComputerName,
		[Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [int64]$Port
	)

	trap { return $false }
	$socket = New-Object System.Net.Sockets.TCPClient($ComputerName,$Port)
	$socket.Close()
	return $true
}