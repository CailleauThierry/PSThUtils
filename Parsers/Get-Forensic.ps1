<#
	.SYNOPSIS
		Get-Forensic works on collected logs from Evault AFC (Agent Forensics Collector) utility and other forensic collections

	.DESCRIPTION
		Get-Forensic.ps1 updated on 05_28_2024
		- Now supports taking parameter from the Pipeline, this should allow for a master selector
		- Now works from $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\ for future ease of sharing it.
		- Extracts 
			* AFC-*\.zip'
			* afc_linux.tar.gz'
			* DFC-*\.zip'
			* PFC-*\.zip'
			* *.nfo'
			* .*\.CAT'
			* .*\.DTA'
			* .*\.evtx'
			* .*\.log or .*\.txt'
		Might detect content in the future
		Bug fixes: would only read event logs in mm/d/yyyy format whereas W2K8 is in mm-d-yyyy
		New features: is backward compatible with old AFC logs still producing App and sys .evtx event logs instead of the App and sys .csv
		To do: could create a directory structured object

	.PARAMETER  ParameterA
		Only takes 1 single file with complete path. Where '*' can be any charaters before the suuported  extension like'.zip', '.nfo'...
          	* AFC-*\.zip
			* afc_linux.tar.gz
			* DFC-*\.zip (careful a file called DFC-#******.zip the "# could cause a bug")
			* PFC-*\.zip
			* *.nfo
			* .*\.CAT
			* .*\.DTA
			* .*\.evtx
			* .*\.log or .*\.txt
	.EXAMPLE
		Shift Drag&Drop (Works on Windows 10 but not on Windows 11 anymore) AFC-.*.zip or DFC-.*.zip or PFC-.*.zip or afc_linux.tar.gz or CAT-.*.zip or .*.log .*.txt file to "Get-Forensic.ps1 - Shortcut" place on windows taskbar

	.EXAMPLE
		PS C:\> Launch "Get-Forensic.ps1 - Shortcut" and type in the full "AFC-.*.zip or DFC-.*.zip or PFC-.*.zip or afc_linux.tar.gz or CAT-.*.zip or .*.log" .*.txt path like:
		C:\posh\AFC-.*.zip
	.EXAMPLE
		Get-Forensic.ps1 is now callable from Pipeline, the script in itself is the function Name
		PS C:\> gci c:\Temp\06xxxxxx\01234567\DFC-01234567-S174881X7719055-2021-06-23-09-40-11-519.zip | .\Get-Forensic.ps1

	.INPUTS
		System.String

	.OUTPUTS
		Directory and file writen on drive

	.NOTES
		Additional information about the function go here.

	.LINK
		about_functions_advanced

	.LINK
		about_comment_based_help

#>


param ( 
[Parameter(Mandatory=$true,ValueFromPipeline=$true)] 
[string]$FullForensicPath
)

$sb_name = ($FullForensicPath).Split('\\')[-1]

if (($sb_name) -match "AFC-.*\.zip")
{
    $FullForensicPath | . $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-AFC.ps1
} 
elseif(($sb_name) -match "afc_linux.tar.gz")
{
    Write-Host 'did not find AFC-*.zip'
    $FullForensicPath | . $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-AFCLinux.ps1
}
elseif(($sb_name) -match "DFC-.*\.zip")
{
    Write-Host 'did not find AFC-*.zip'
    Write-Host 'did not find afc_linux.tar.gz'
    $FullForensicPath | . $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-DFC.ps1
}
elseif(($sb_name) -match "PFC-.*\.zip")
{
    Write-Host 'did not find AFC-*.zip'
    Write-Host 'did not find afc_linux.tar.gz'
    Write-Host 'did not find DFC-*.zip'
    $FullForensicPath | . $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-PFC.ps1
}
elseif(($sb_name) -match ".*\.nfo")
{
    Write-Host 'did not find AFC-*.zip'
    Write-Host 'did not find afc_linux.tar.gz'
    Write-Host 'did not find DFC-*.zip'
    Write-Host 'did not find PFC-*.zip'	
	. $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-MSInfo.ps1
    Get-ChildItem -LiteralPath (($FullForensicPath).Replace("$sb_name","")) -Filter *.nfo | Get-MSInfo
}
elseif(($sb_name) -match ".*\.CAT")
{
    Write-Host 'did not find AFC-*.zip'
    Write-Host 'did not find afc_linux.tar.gz'
    Write-Host 'did not find DFC-*.zip'
    Write-Host 'did not find PFC-*.zip'
	Write-Host 'did not find *.nfo'
	. $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Converter\Get-EVCAT.ps1
    Get-ChildItem -LiteralPath (($FullForensicPath).Replace("$sb_name","")) -Filter *.CAT -Recurse | Get-EVCAT
}
elseif(($sb_name) -match ".*\.DTA")
{
    Write-Host 'did not find AFC-*.zip'
    Write-Host 'did not find afc_linux.tar.gz'
    Write-Host 'did not find DFC-*.zip'
    Write-Host 'did not find PFC-*.zip'
	Write-Host 'did not find *.nfo'
	Write-Host 'did not find .*\.CAT'
	. $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Converter\Get-EVDTA.ps1
	Get-ChildItem -LiteralPath (($FullForensicPath).Replace("$sb_name","")) -Filter *.DTA -Recurse | Get-EVDTA
}
elseif(($sb_name) -match ".*\.evtx")
{
    Write-Host 'did not find AFC-*.zip'
    Write-Host 'did not find afc_linux.tar.gz'
    Write-Host 'did not find DFC-*.zip'
    Write-Host 'did not find PFC-*.zip'
	Write-Host 'did not find *.nfo'
	Write-Host 'did not find .*\.CAT'
	Write-Host 'did not find .*\.DTA'
	. $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Converter\Get-EVTX.ps1
	Get-ChildItem -LiteralPath $FullForensicPath | Get-EVTX
}
elseif(($sb_name) -match ".*\.log|.*\.txt")
{
    Write-Host 'did not find AFC-*.zip'
    Write-Host 'did not find afc_linux.tar.gz'
    Write-Host 'did not find DFC-*\.zip'
    Write-Host 'did not find PFC-*\.zip'
	Write-Host 'did not find *.nfo'
	Write-Host 'did not find .*\.CAT'
	Write-Host 'did not find .*\.DTA'
	Write-Host 'did not find .*\.evtx'
    Write-Host ("$sb_name" + "'s content is in the clipboard ready for you to paste! `n List of Exception(s) (if any) shown in the following entrie(s) that could not be found in this file:`n")
    $FullForensicPath | . $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-DescriptionFromLog.ps1
}

else
{
    Write-Host 'did not find AFC-*\.zip'
    Write-Host 'did not find afc_linux.tar.gz'
    Write-Host 'did not find DFC-*\.zip'
    Write-Host 'did not find PFC-*\.zip'
	Write-Host 'did not find *.nfo'
	Write-Host 'did not find .*\.CAT'
	Write-Host 'did not find .*\.DTA'
	Write-Host 'did not find .*\.evtx'
    Write-Host 'did not find .*\.log or .*\.txt'
break
}