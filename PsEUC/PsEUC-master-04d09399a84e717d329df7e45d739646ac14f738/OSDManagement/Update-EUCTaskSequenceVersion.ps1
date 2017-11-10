
function Update-EUCTaskSequenceVersion
{

    Get-EUCNextVersionNumber -Version -Increment 

    $taskSequencesFile = [xml]$(Get-content \\m370prd1\deploymentsharedev$\Control\TaskSequences.xml)
    $taskSequencesFile.SelectSingleNode('/tss/ts[@guid="{62bdab20-db7d-4e1f-b701-f204206d7505}"]/Version')."#text" = "2.7.0+osd.2015-01-13"
    $taskSequencesFile.Save("\\m370prd1\deploymentsharedev$\Control\TaskSequences.xml")

}

