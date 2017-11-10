<#
.SYNOPSIS
    Return a date in the future
.DESCRIPTION
    Using the specified number of days, return a date in the future. In addition only working days (Monday-Friday) can be included
.EXAMPLE
    Get-DateInFutureByDays -Time '10:00am' -Days 4 -WorkWeekOnly
#>
function Get-DateInFutureByDays
{
    [CmdletBinding()]
    [OutputType([DateTime])]
    Param
    (
        # The time (not the date) of the future datetime
        [Parameter(Mandatory=$true, Position=0)]
        [DateTime]$Time,
        # Number of days in the future
        [Parameter(Mandatory=$true, Position=1)]
        [int]$Days,
        # Return only future days between Monday-Friday
        [switch]$WorkWeekOnly
    )

    $newDate = $($(Get-Date $Time).AddDays($Days))

    if ($WorkWeekOnly)
    {
        if ($newDate.DayOfWeek -eq 'Saturday')
        {
            $newDate = $newDate.AddDays(2)
        }

        if ($newDate.DayOfWeek -eq 'Sunday')
        {
            $newDate = $newDate.AddDays(1)
        }
    }

    Write-Output $newDate
}

