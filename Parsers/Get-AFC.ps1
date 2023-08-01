<#
	.SYNOPSIS
		Get-AFC works on collected logs from Evault AFC (Agent Forensics Collector) utility

	.DESCRIPTION
		Get-AFC.ps1 
		Current Changes:
		Now supports taking parameter fromt he Pipeline, this sohuld allow for a master selector
		Previous Changes
		Now works from $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\ for future ease of sharing it.
		- Extracts AFC-.*.zip (must be in this format for now). Might detect content in the future
		Bug fixes: would only read event logs in mm/d/yyyy format whereas W2K8 is in mm-d-yyyy
		New features: is backward compatible with old AFC logs still producing App and sys .evtx event logs instead of the App and sys .csv
		To do: could create a directory structured object

	.PARAMETER  ParameterA
		Only takes 1 single AFC-.*.zip file with complete path. Where '*' can be any charaters before the '.zip' extension

	.EXAMPLE
		Shift Drag&Drop AFC-.*.zip file to "Get-AFC.ps1 - Shortcut" place on windows taskbar

	.EXAMPLE
		PS C:\> Launch "Get-AFC.ps1 - Shortcut" and type in the full "AFC-.*.zip" path like:
		C:\posh\AFC-.*.zip
	.EXAMPLE
		Get-AFC.ps1 is now callable from Pipeline, the script in itself is the function Name
		PS C:\> gci c:\Temp\06xxxxxx\06292650\DFC-06292650-S174881X7719005-2021-06-23-09-40-11-519.zip | .\Get-AFC.ps1

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
[Parameter(
	Mandatory=$true,
	ValueFromPipeline=$true
	)
] 
[string]$AFCZip
)
# Passing AFC password from SecretStore CredMan
. $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-7zip_PSW.ps1
# This requires a Evault Agent to be installed to leverage on Xtranslator.exe utility
. $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\xtranslate_18.ps1

# Obtains AFC full file name from the full file path collected in $AFCZip
$sb_name = ($AFCZip).Split('\\')[-1]

if (($sb_name) -match "AFC-.*.zip")
{


#extract bz2 and create a sub-directory 1 (non-configurable). The extract folder / directory is created by 7z called within Invoke-SevenZipPswd function defined in Get-7zip_PSW_00_01.ps1
$subdir1 = (Get-ChildItem $AFCZip | Invoke-SevenZipPswdCMAFC)[-1]
# Note: This still does not test if AFC file is a valid zip file
} 
else
{
Write-Host 'did not find AFC-*.zip'
Write-Host "We only got $sb_name"
break
}

# Navigates to the created directory as returned by Invoke-SevenZipPswd
$AFCExtractPath = ($AFCZip.TrimEnd("$sb_name") + $subdir1)
# String handling to remove any logs older than last year
$lastyear = (get-date).AddMonths(-12).Year

Write-Host " Removing bulky .CAT files and..."
Write-Host " ...translating .XLOG to text searcheable .XLOG.log..."

Remove-Item "$AFCExtractPath\*\*.CAT" -Recurse

Get-ChildItem "$AFCExtractPath\*\*.XLOG" -Recurse | Get-XLogTranslator

Get-ChildItem "$AFCExtractPath\*.XLOG" -Recurse | Get-XLogTranslator

Write-Host "....CAT files removed and .XLOG.log done."

Write-Host "filtering event logs including last year's ones..."

# Only gets the first directory level list of files

Get-ChildItem $AFCExtractPath | ForEach-Object {
	switch ($_.Name)
	{
		"app.csv" {
			#Application Event			
			Write-Output "Application Event Errors and Warnings--------------------------------------------------------------------------------------------------------------------------------" | Out-File $AFCExtractPath\app.csv_filtered.log -NoClobber
			Import-Csv $AFCExtractPath\app.csv | Where-Object {$_.'Date and Time'.Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"}  | Where-Object {$_.Level -like "Error" -or $_.Level -like "Warning"} | Out-File $AFCExtractPath\app.csv_filtered.log -Append
			break
		}
		"sys.csv" {
			# System Event
			Write-Output "System Event Errors, Warnings and System Uptime--------------------------------------------------------------------------------------------------------------------------------------" | Out-File $AFCExtractPath\sys.csv_filtered.log -NoClobber
			Import-Csv $AFCExtractPath\sys.csv | Where-Object {$_.'Date and Time'.Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"} | Where-Object {$_.Level -like "Error" -or $_.Level -like "Warning" -or $_.Id -like "6013"} | Out-File $AFCExtractPath\sys.csv_filtered.log -Append
			break
		}
		
		"App.evtx" {
			# Get-WinEvent -Path $AFCExtractPath\App.evtx
			$GWEAppEvtx = Get-WinEvent -Path $AFCExtractPath\App.evtx
			Write-Output "Application Event Errors or Warnings ---------------------------------------------------------------------------------------------------------------------------------" | Out-File $AFCExtractPath\App.evtx_filtered.log -NoClobber
			$GWEAppEvtx | Where-Object {$_.TimeCreated.ToString().Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"} | Where-Object {$_.LevelDisplayName -like "Error" -or $_.LevelDisplayName -like "Warning"}  |  Format-List -Property LevelDisplayName,TimeCreated,ProviderName,Id,Keywords,ProcessId,MachineName,UserId,Message  | Out-File $AFCExtractPath\App.evtx_filtered.log -Width 300 -Append
			break
		}
		"Sys.evtx" {
			# Get-WinEvent -Path $AFCExtractPath\Sys.evtx
			$GWESysEvtx = Get-WinEvent -Path $AFCExtractPath\Sys.evtx			
			Write-Output "System Event Errors, Warnings and System Uptime--------------------------------------------------------------------------------------------------------------------------------------" | Out-File $AFCExtractPath\Sys.evtx_filtered.log -NoClobber
			$GWESysEvtx | Where-Object {$_.TimeCreated.ToString().Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"} | Where-Object {$_.LevelDisplayName -like "Error" -or $_.LevelDisplayName -like "Warning" -or $_.Id -like "6013"} | Format-List -Property LevelDisplayName,TimeCreated,ProviderName,Id,Keywords,ProcessId,MachineName,UserId,Message | Out-File $AFCExtractPath\Sys.evtx_filtered.log -Width 300 -Append
			break
		}
		default {
			# checking content of $_ as seen by the switch statement
			# What did not get selected by switch
			break
		}
	}
}


Write-Host "...Application and System logs filtered filtering completed"

