function Set-RmDocument {
    [CmdletBinding()]
    param(
        [string]$RecordNumber,
        [string]$FilePath,
        [string]$SdkPath = 'c:\Program Files\Hewlett Packard Enterprise\Records Manager\HP.HPTRIM.SDK.dll',
        [string]$RmDatabaseId = 'C1',
        [string]$RmServerName = 'hprm8prd.bcc.qld.gov.au'
    )
    
	try {
    Add-Type -Path $SdkPath
} catch {}

    try {
        $database = New-Object HP.HPTRIM.SDK.Database
        $database.Id = $RmDatabaseId
        $database.WorkgroupServerName = $RmServerName
        $database.Connect()

        $record = New-Object HP.HPTRIM.SDK.Record($database, $RecordNumber)
        $document = New-Object HP.HPTRIM.SDK.InputDocument
        $document.SetAsFile($FilePath)
        # upload document, create a new revision, and don't keep it check out
        $record.SetDocument($document, $true, $false, '')
        $record.Save()
    }
    catch [System.Exception] {
    }
    finally {
        $database.Dispose()
    }
}