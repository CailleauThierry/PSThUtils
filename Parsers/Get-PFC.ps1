# Get-PFC.ps1 based on working Get-DPFC.ps1. Using the AFC algorithmto merge Error and Warnigns and also handle .evtx format
# plan is to make Cmdlets
# could create a directory structure object
param ( 
[Parameter(
	Mandatory=$true,
	ValueFromPipeline=$true
	)
] 
[string]$PFCZip
)
# Passing AFC password from SecretStore CredMan
. $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-7zip_PSW.ps1

$sb_name = ($PFCZip).Split('\\')[-1]

if (($sb_name) -match "PFC-.*.zip")
{


#extract bz2 and create a sub-directory 1 (non-configurable)
$subdir1 = (Get-ChildItem $PFCZip | Invoke-SevenZipPswdCMPFC)[-1]

} 
else
{
Write-Host 'did not find PFC-something.zip'
Write-Host "We only got $sb_name"
break
}

# Navigates to the created directory as returned by Invoke-SevenZipPswd
$PFCExtractPath = ($PFCZip.TrimEnd("$sb_name") + $subdir1)
# String handling to remove any logs older than last year
$lastyear = (get-date).AddMonths(-12).Year

Write-Host "Extra filtering ongoing..."
Get-ChildItem $PFCExtractPath | ForEach-Object {
	switch ($_.Name)
	{
		"app.csv" {
			#Application Event			
			Write-Output "Application Event Errors and Warnings--------------------------------------------------------------------------------------------------------------------------------" | Out-File $PFCExtractPath\app.csv_filtered.log -NoClobber
			Import-Csv $PFCExtractPath\app.csv | Where-Object {$_.'Date and Time'.Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"}  | Where-Object {$_.Level -like "Error" -or $_.Level -like "Warning"} | Out-File $PFCExtractPath\app.csv_filtered.log -Append
			break
		}
		"sys.csv" {
			# System Event
			Write-Output "System Event Errors, Warnings and System Uptime--------------------------------------------------------------------------------------------------------------------------------------" | Out-File $PFCExtractPath\sys.csv_filtered.log -NoClobber
			Import-Csv $PFCExtractPath\sys.csv | Where-Object {$_.'Date and Time'.Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"} | Where-Object {$_.Level -like "Error" -or $_.Level -like "Warning" -or $_.Id -like "6013"} | Out-File $PFCExtractPath\sys.csv_filtered.log -Append
			break
		}
		
		"App.evtx" {
			# Get-WinEvent -Path $PFCExtractPath\App.evtx
			# "-ErrorAction SilentlyContinue" to Workaround for "The description string for parameter reference (%1) could not be found" as per "https://github.com/EvotecIT/PSEventViewer/issues/6
			$GWEAppEvtx = Get-WinEvent -Path $PFCExtractPath\App.evtx -ErrorAction SilentlyContinue
			Write-Output "Application Event Errors or Warnings ---------------------------------------------------------------------------------------------------------------------------------" | Out-File $PFCExtractPath\App.evtx_filtered.log -NoClobber
			$GWEAppEvtx | Where-Object {$_.TimeCreated.ToString().Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"} | Where-Object {$_.LevelDisplayName -like "Error" -or $_.LevelDisplayName -like "Warning"}  |  Format-List -Property LevelDisplayName,TimeCreated,ProviderName,Id,Keywords,ProcessId,MachineName,UserId,Message  | Out-File $PFCExtractPath\App.evtx_filtered.log -Width 300 -Append
			break
		}
		"Sys.evtx" {
			# Get-WinEvent -Path $PFCExtractPath\Sys.evtx
			# "-ErrorAction SilentlyContinue" to Workaround for "The description string for parameter reference (%1) could not be found" as per "https://github.com/EvotecIT/PSEventViewer/issues/6
			$GWESysEvtx = Get-WinEvent -Path $PFCExtractPath\Sys.evtx -ErrorAction SilentlyContinue		 	
			Write-Output "System Uptime then System Event Errors and Warnings  --------------------------------------------------------------------------------------------------------------------------------------" | Out-File $AFCExtractPath\Sys.evtx_filtered.log -NoClobber
			$GWESysEvtx | Where-Object {$_.TimeCreated.ToString().Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"} | Where-Object {$_.Id -like "6013"} | Format-List -Property LevelDisplayName,TimeCreated,ProviderName,Id,Keywords,ProcessId,MachineName,UserId,Message | Out-File $AFCExtractPath\Sys.evtx_filtered.log -Width 300 -Append
			$GWESysEvtx | Where-Object {$_.TimeCreated.ToString().Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"} | Where-Object {$_.LevelDisplayName -like "Error" -or $_.LevelDisplayName -like "Warning"} | Format-List -Property LevelDisplayName,TimeCreated,ProviderName,Id,Keywords,ProcessId,MachineName,UserId,Message | Out-File $PFCExtractPath\Sys.evtx_filtered.log -Width 300 -Append
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

