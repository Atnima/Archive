function New-EUCWDSBootImage
{
    [CmdletBinding()]
    Param
    (

    )

    # http://www.deployvista.com/Blog/JohanArwidmark/tabid/78/EntryID/54/Default.aspx

    $WINPE_WORKING_FOLDER = 'C:\temp\winpe'

    Copy-Item -Path "\\m562prd1\src$\CM_Managed\OSD\WinPE_10.0.10586\winpe.KA10022B.wim" -Destination 'c:\temp'

    $result = Mount-WindowsImage -ImagePath "c:\temp\winpe.KA10022B.wim" -Path "$WINPE_WORKING_FOLDER" -Index 1
    New-Item -Path "c:\temp\winpe\SMS" -Name "data" -ItemType Directory
    Copy-Item -Path '\\m562prd1\src$\CM_Managed\OSD\WinPE_10.0.10586\TsmBootstrap.ini' -Destination "c:\temp\winpe\SMS\data"
    Copy-Item -Path '\\m562prd1\src$\CM_Managed\OSD\WinPE_10.0.10586\Variables.dat' -Destination "c:\temp\winpe\SMS\data"
    $result = Dismount-WindowsImage -Path "$WINPE_WORKING_FOLDER" -Save

}