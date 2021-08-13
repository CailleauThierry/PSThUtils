# Get-SupportBundle_12.ps1 based on Get-SupportBundle_11.ps1. Testing it with powershell 3
# plan is to make Cmdlets
# could create a directory structure object
# option to xtranslate xlog
# option to remove .CAT
param ( 
[Parameter(
	Mandatory=$true,
	ValueFromPipeline=$true
	)] [string]$SupportBundle # = "C:\Temp\06xxxxxx\06272630\afc_linux.tar.gz"
)

# Standard 7zip call without password
. $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-7zip.ps1

# This requires a Evault Agent to be installed to leverage on Xtranslator.exe utility
. $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\xtranslate_18.ps1

$sb_name = ($SupportBundle -split '\\')[-1]
$sb_Folder = $SupportBundle.TrimEnd("$sb_name")

if (($sb_name) -match "afc_linux.tar.gz")
{
#$ExtractOptions = "-o$sb_Folder"
#$ZipFileFull = $sb_Folder + $Matches[0]
#$szResult1 = sz x $ZipFileFull -y $ExtractOptions

#extract gz and create a sub-directory 1 (non-configurable)
$subdir1 = (Get-ChildItem $SupportBundle | Invoke-SevenZipCMAFCLinux)[-1]

#extract tar from sub-directory 1 and creates a sub-directory 2
$subdir2 = (gci "$sb_Folder$subdir1\*.tar" | Invoke-SevenZipCMAFCLinux)[-1]

} 
else
{
Write-Host 'did not find afc_linux.tar.gz'
Write-Host "We only got $sb_name"
break
}

# Remove-Item "$sb_Folder$subdir1\$subdir2\agent\*\*.CAT" -Recurse

Get-ChildItem "$sb_Folder$subdir1\$subdir2\$subdir2\agent\*\*.XLOG" -Recurse | Get-XLogTranslator