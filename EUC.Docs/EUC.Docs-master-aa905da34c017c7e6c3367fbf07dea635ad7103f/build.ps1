[CmdletBinding()]
param (
    [switch]$NoProxy,
    [switch]$OpenOutput
)
    
$PROXY = "http://175.45.116.34:10170"

$WKHTMLPATH = 'C:\Program Files (x86)\wkhtmltopdf\bin'
$PANDOCPATH = 'C:\Program Files (x86)\Pandoc'

$TEMPMDFILE = "$($env:TEMP)\euc.docs.md"
$TEMPHTMLFILE = "$($env:TEMP)\euc.docs.html"
$OUTPUTFILE = "$($env:TEMP)\euc.docs.pdf"

$STYLINGTOP = @'
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.9.0/styles/default.min.css">
<!--<link rel="stylesheet" href="https://static2.sharepointonline.com/files/fabric/office-ui-fabric-core/4.1.0/css/fabric.min.css">-->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.9.0/highlight.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/9.4.0/languages/powershell.min.js"></script>
<script>hljs.initHighlightingOnLoad();</script>
<span class="ms-font-l ms-fontColor-neutralPrimary">
<div class="container">
<!-- disable pandoc not wrapping code blocks -->
<style type="text/css">pre, code { white-space: pre-wrap !important; }</style>
'@

$STYLINGBOTTOM = @'
</span>
</div>
'@

$STYLINGTOP = ''
$STYLINGBOTTOM = ''

# test for exe files


# create one big markdown files
$markdownContents = ""
foreach ($entry in $(Get-Content -Path "$PSScriptRoot\DocumentsToMerge.txt")) {
    if ($entry -notmatch '^;') {
        # append the content and add a couple of newlines
        $markdownContents += "$(Get-Content -Path "$PSScriptRoot\$entry" -Raw) `r`n `r`n"
    }
}

Set-Content -Path $TEMPMDFILE -Value $markdownContents

# turn that in to html
Start-Process -FilePath "$PANDOCPATH\pandoc.exe" -ArgumentList "-s --toc --toc-depth 2 --template html_template.html $TEMPMDFILE -o $TEMPHTMLFILE" -Wait -NoNewWindow

# add styling

$htmlContents = Get-Content $TEMPHTMLFILE -Raw
$htmlContents = $htmlContents.Replace('<table style="width:28%;">', '<table class="table table-bordered">')
$htmlContents = $htmlContents.Replace('<table style="width:11%;">', '<table class="table table-bordered">')
Set-Content -Path $TEMPHTMLFILE -Value $($STYLINGTOP + $htmlContents + $STYLINGBOTTOM)

<#
# generate PDF
if ($NoProxy) {
    Start-Process -FilePath "$WKHTMLPATH\wkhtmltopdf.exe" -ArgumentList "$TEMPHTMLFILE $OUTPUTFILE" -Wait -NoNewWindow
} else {
    Start-Process -FilePath "$WKHTMLPATH\wkhtmltopdf.exe" -ArgumentList "--proxy $Proxy $TEMPHTMLFILE $OUTPUTFILE" -Wait -NoNewWindow
}

if ($OpenOutput) {
    & "$OUTPUTFILE"
}

# upload to records manager

#>