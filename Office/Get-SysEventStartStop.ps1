<#	
    .NOTES
    ===========================================================================
    Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2017 v5.4.135
    Created on:   	3/3/2017 7:39 AM
    Created by:   	CailleauThierry
    Organization: 	Private
    Filename:     	Get-SysEventStartStop.ps1
    ===========================================================================
    .DESCRIPTION
      Collects Windows System Event log relative to Event log start and stop time (i.e. OS login logout time) 
    Gets computer start and stop time for the last 3 Month
    .EXAMPLE
      .\Get-SysEventStartStop.ps1 # gets its inout from System Event logs and place the last 3 month results as .csv in $HOME\Documents\WindowsPowerShell\TimedTask_Logs\FormatedLogin.csv
    Alternatively run Get-SysEventStartStop_v0.0.1.exe or by launching Get-SysEventStartStop.bat which will run Get-SysEventStartStop.ps1
#>

$outfile = Get-Item "$HOME\Documents\WindowsPowerShell\TimedTask_Logs\FormatedLogin.csv"

if (Test-Path $outfile) { # Test if file full path (string) stored in $outfile exist. If yes, deletes it
  $Silent = Remove-Item $outfile 
}

$importedtable = Get-EventLog -LogName System -After ((get-date).AddMonths(-3)) -Source EventLog -ComputerName $env:COMPUTERNAME -AsBaseObject |
Where-Object -Property EventID -match '6005|6006' | 
Select-Object TimeGenerated,Message # | Export-Csv -Path $HOME\Documents\WindowsPowerShell\TimedTask_Logs\eventlog.csv -NoClobber -NoTypeInformation

#$importedtable = Import-Csv $HOME\Documents\WindowsPowerShell\TimedTask_Logs\eventlog.csv

$importedtable = $importedtable | Sort-Object TimeGenerated -Unique

$importedtable | ForEach-Object { 
  $Duration = '0'
  $Category = 'System Event'
  $Ticket = 'N/A'
  $_ | 
  Add-Member -MemberType NoteProperty -Name Duration -Value $Duration -PassThru | 
  Add-Member -MemberType NoteProperty -Name Category -Value $Category -PassThru |
  Add-Member -MemberType NoteProperty -Name Ticket -Value $Ticket -PassThru |
  Select-Object -Property	@{
    expression = {
      $_.TimeGenerated
    }; label = 'DateTime'
  },Duration,Category,Ticket,@{expression = {$_.Message}; label = 'Activity'} |
  Export-Csv -Path $HOME\Documents\WindowsPowerShell\TimedTask_Logs\FormatedLogin.csv -NoClobber -NoTypeInformation -Append
}
#Cleaning up generated (ned to create new .csv as the imported one is still open i.e. can only get appended))
