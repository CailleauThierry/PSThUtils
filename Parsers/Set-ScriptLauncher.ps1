# Comment out the Scripts you do not want to run
$Selector = "Get-MSInfo", "NoSelection"


$Selector | ForEach-Object {
	switch ($_)
	{
		"Get-MSInfo" {
			#Application Event			
            # Get-MSinfo.ps1 now resets arrays to allow for multiple .nfo to be handled. Get-MSINFOTOO.ps1 passes those multipe *.nfo files to it.

            . $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-MSInfo.ps1
            Get-ChildItem C:\Temp\msinfo32_de.nfo -Filter *.nfo -Recurse | Select-Object -Property FullName | Get-MSInfo   
            break
		}
		"sys.csv" {
			# System Event
			Write-Output "System Uptime Information + System Event Errors and Warnings  --------------------------------------------------------------------------------------------------------------------------------------" | Out-File $AFCExtractPath\sys.csv_filtered.log -NoClobber
			Import-Csv $AFCExtractPath\sys.csv | Where-Object {$_.'Date and Time'.Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"} | Where-Object {$_.Id -like "6013"} | Out-File $AFCExtractPath\sys.csv_filtered.log -Append
			Import-Csv $AFCExtractPath\sys.csv | Where-Object {$_.'Date and Time'.Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"} | Where-Object {$_.Level -like "Error" -or $_.Level -like "Warning"} | Out-File $AFCExtractPath\sys.csv_filtered.log -Append
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
			Write-Output "System Uptime Information + System Event Errors and Warnings  --------------------------------------------------------------------------------------------------------------------------------------" | Out-File $AFCExtractPath\Sys.evtx_filtered.log -NoClobber
			$GWESysEvtx | Where-Object {$_.TimeCreated.ToString().Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"} | Where-Object {$_.Id -like "6013"} | Format-List -Property LevelDisplayName,TimeCreated,ProviderName,Id,Keywords,ProcessId,MachineName,UserId,Message | Out-File $AFCExtractPath\Sys.evtx_filtered.log -Width 300 -Append
			$GWESysEvtx | Where-Object {$_.TimeCreated.ToString().Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"} | Where-Object {$_.LevelDisplayName -like "Error" -or $_.LevelDisplayName -like "Warning"} | Format-List -Property LevelDisplayName,TimeCreated,ProviderName,Id,Keywords,ProcessId,MachineName,UserId,Message | Out-File $AFCExtractPath\Sys.evtx_filtered.log -Width 300 -Append
			break
		}
		"msinfo32.nfo" {
			# Get-WinEvent -Path $AFCExtractPath\Sys.evtx
			$GWESysEvtx = Get-WinEvent -Path $AFCExtractPath\Sys.evtx			
			Write-Output "System Uptime Information + System Event Errors and Warnings  --------------------------------------------------------------------------------------------------------------------------------------" | Out-File $AFCExtractPath\Sys.evtx_filtered.log -NoClobber
			$GWESysEvtx | Where-Object {$_.TimeCreated.ToString().Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"} | Where-Object {$_.Id -like "6013"} | Format-List -Property LevelDisplayName,TimeCreated,ProviderName,Id,Keywords,ProcessId,MachineName,UserId,Message | Out-File $AFCExtractPath\Sys.evtx_filtered.log -Width 300 -Append
			$GWESysEvtx | Where-Object {$_.TimeCreated.ToString().Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"} | Where-Object {$_.LevelDisplayName -like "Error" -or $_.LevelDisplayName -like "Warning"} | Format-List -Property LevelDisplayName,TimeCreated,ProviderName,Id,Keywords,ProcessId,MachineName,UserId,Message | Out-File $AFCExtractPath\Sys.evtx_filtered.log -Width 300 -Append
			
			Get-ChildItem -LiteralPath (($FullForensicPath).Replace("$sb_name","")) -Filter *.nfo | Get-MSInfo
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
