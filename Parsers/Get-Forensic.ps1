<#
	.SYNOPSIS
		Get-Forensic works on collected logs from Evault AFC (Agent Forensics Collector) utility

	.DESCRIPTION
		Get-Forensic.ps1 
		Current Changes:
		Now supports taking parameter fromt he Pipeline, this sohuld allow for a master selector
		Previous Changes
		Now works from $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\ for future ease of sharing it.
		- Extracts AFC-.*.zip or DFC-.*.zip or PFC-.*.zip or afc_linux.tar.gz or .*.log (must be in this format for now). Might detect content in the future
		Bug fixes: would only read event logs in mm/d/yyyy format whereas W2K8 is in mm-d-yyyy
		New features: is backward compatible with old AFC logs still producing App and sys .evtx event logs instead of the App and sys .csv
		To do: could create a directory structured object

	.PARAMETER  ParameterA
		Only takes 1 single AFC-.*.zip or DFC-.*.zip or PFC-.*.zip or afc_linux.tar.gz or .*.log file with complete path. Where '*' can be any charaters before the '.zip' extension

	.EXAMPLE
		Shift Drag&Drop AFC-.*.zip or DFC-.*.zip or PFC-.*.zip or afc_linux.tar.gz or .*.log file to "Get-Forensic.ps1 - Shortcut" place on windows taskbar

	.EXAMPLE
		PS C:\> Launch "Get-Forensic.ps1 - Shortcut" and type in the full "AFC-.*.zip or DFC-.*.zip or PFC-.*.zip or afc_linux.tar.gz or .*.log" path like:
		C:\posh\AFC-.*.zip
	.EXAMPLE
		Get-Forensic.ps1 is now callable from Pipeline, the script in itself is the function Name
		PS C:\> gci c:\Temp\06xxxxxx\06292650\DFC-06292650-S174881X7719005-2021-06-23-09-40-11-519.zip | .\Get-Forensic.ps1

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
[Parameter(Mandatory=$true)] 
[string]$FullForensicPath
)

<# . $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-AFCLinux.ps1
. $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-DFC.ps1
. $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-PFC.ps1 #>

$sb_name = ($FullForensicPath).Split('\\')[-1]

if (($sb_name) -match "AFC-.*.zip")
{
    $FullForensicPath | . $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-AFC.ps1
} 
else
{
Write-Host 'did not find AFC-*.zip'
Write-Host "We only got $sb_name"
break
}