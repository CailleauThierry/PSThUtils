# Get-DFC.ps1 based on working Get-DFC.ps1. Using the AFC algorithmto merge Error and Warnigns and also handle .evtx format
# plan is to make Cmdlets
# could create a directory structure object
param ( 
[Parameter(mandatory=$true)] [string]$DFCZip
)
# I had to revert to Get-7zip_PSW_00_01.ps1 as the "-assecurestring" does not play nice with 7-zip
. C:\posh\Get-7zip_PSW.ps1

$sb_name = ($DFCZip).Split('\\')[-1]

if (($sb_name) -match "DFC-.*.zip")
{


#extract bz2 and create a sub-directory 1 (non-configurable)
$subdir1 = (Get-ChildItem $DFCZip | Invoke-SevenZipPswd)[-1]

} 
else
{
Write-Host 'did not find DFC-something.zip'
}

# Navigates to the created directory as returned by Invoke-SevenZipPswd
$DFCExtractPath = ($DFCZip.TrimEnd("$sb_name") + $subdir1)
# String handling to remove any logs older than last year
$lastyear = (get-date).AddMonths(-12).Year

Write-Host "Extra filtering ongoing..."
Get-ChildItem $DFCExtractPath | ForEach-Object {
	switch ($_.Name)
	{
		"app.csv" {
			#Application Event			
			Write-Output "Application Event Errors and Warnings--------------------------------------------------------------------------------------------------------------------------------" | Out-File $DFCExtractPath\app.csv_filtered.txt -NoClobber
			Import-Csv $DFCExtractPath\app.csv | where {$_.'Date and Time'.Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"}  | where {$_.Level -like "Error" -or $_.Level -like "Warning"} | Out-File $DFCExtractPath\app.csv_filtered.txt -Append
			break
		}
		"sys.csv" {
			# System Event
			Write-Output "System Event Errors and Warnings--------------------------------------------------------------------------------------------------------------------------------------" | Out-File $DFCExtractPath\sys.csv_filtered.txt -NoClobber
			Import-Csv $DFCExtractPath\sys.csv | where {$_.'Date and Time'.Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"} | where {$_.Level -like "Error" -or $_.Level -like "Warning"} | Out-File $DFCExtractPath\sys.csv_filtered.txt -Append
			break
		}
		
		"App.evtx" {
			# Get-WinEvent -Path $DFCExtractPath\App.evtx
			$GWEAppEvtx = Get-WinEvent -Path $DFCExtractPath\App.evtx
			Write-Output "Application Event Errors or Warnings ---------------------------------------------------------------------------------------------------------------------------------" | Out-File $DFCExtractPath\App.evtx_filtered.txt -NoClobber
			$GWEAppEvtx | where {$_.TimeCreated.ToString().Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"} | where {$_.LevelDisplayName -like "Error" -or $_.LevelDisplayName -like "Warning"}  |  Format-List -Property LevelDisplayName,TimeCreated,ProviderName,Id,Keywords,ProcessId,MachineName,UserId,Message  | Out-File $DFCExtractPath\App.evtx_filtered.txt -Width 300 -Append
			break
		}
		"Sys.evtx" {
			# Get-WinEvent -Path $DFCExtractPath\Sys.evtx
			$GWESysEvtx = Get-WinEvent -Path $DFCExtractPath\Sys.evtx			
			Write-Output "System Event Errors or Warnings--------------------------------------------------------------------------------------------------------------------------------------" | Out-File $DFCExtractPath\Sys.evtx_filtered.txt -NoClobber
			$GWESysEvtx | where {$_.TimeCreated.ToString().Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"} | where {$_.LevelDisplayName -like "Error" -or $_.LevelDisplayName -like "Warning"} | Format-List -Property LevelDisplayName,TimeCreated,ProviderName,Id,Keywords,ProcessId,MachineName,UserId,Message | Out-File $DFCExtractPath\Sys.evtx_filtered.txt -Width 300 -Append
			break
		}
		default {
			# checking content of $_ as seen by the switch statement
			# What did not get selected by switch
			break
		}
	}
}
Write-Host "...extra filtering completed"

