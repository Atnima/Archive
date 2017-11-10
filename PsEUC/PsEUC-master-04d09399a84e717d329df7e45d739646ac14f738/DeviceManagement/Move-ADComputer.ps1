function Move-ADComputer
{
    <#
    .SYNOPSIS
    Moves the specified computer in Active Directory to a configured destination OU
    .DESCRIPTION
    Moves the specified computer in Active Directory to a configured destination OU
    .LINK
    None
    #>
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [string]$ComputerName,
        [System.Management.Automation.PSCredential]$Credential
    )

    DynamicParam {
            # Set the dynamic parameters' name
            $ParameterName = 'Path'
            
            # Create the dictionary 
            $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary

            # Create the collection of attributes
            $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
            
            # Create and set the parameters' attributes
            $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
            $ParameterAttribute.Mandatory = $true
            $ParameterAttribute.Position = 1

            # Add the attributes to the attributes collection
            $AttributeCollection.Add($ParameterAttribute)

            # Generate and set the ValidateSet 
            $arrSet = Get-EUCSetting -Group AdWorkstationOu | Select-Object -ExpandProperty FriendlyName

            $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($arrSet)

            # Add the ValidateSet to the attributes collection
            $AttributeCollection.Add($ValidateSetAttribute)

            # Create and return the dynamic parameter
            $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $AttributeCollection)
            $RuntimeParameterDictionary.Add($ParameterName, $RuntimeParameter)
            return $RuntimeParameterDictionary
    }

    begin {
        # Bind the parameter to a friendly variable
        $pathParameterName = $PsBoundParameters[$ParameterName]
    }

    process {
        $ou = $((Get-EUCSetting -Group AdWorkstationOu | ? { $_.FriendlyName -eq "$pathParameterName" }).OU)

        Write-Verbose "Moving $ComputerName to $ou"
        if (-Not $Credential)
        {
            Get-ADComputer $ComputerName | Move-ADObject -TargetPath $ou
        }
        else
        {
            Get-ADComputer $ComputerName | Move-ADObject -TargetPath $ou -Credential $Credential
        }
    }
}
