﻿<#
    .NOTES
    ===========================================================================
    Created on:   	Sunday November 20, 2016
    Created by:   	CailleauThierry
    Organization: 	Private
    Filename:		    TimedTask.ps1
    Version:        1.1.2.4
    Started from: 	https://github.com/Windos/powershell-depot/blob/master/General/Timesheet.ps1
    ===========================================================================
    .DESCRIPTION
    This is a simple .csv timesheet generation. Unlike Timesheet.ps1 it does not ask what you are doing every 20 min.
	It record the beginning (whne script is launch) to end (when you select OK after entering the text) and calculate the duration between both in min
    You are meant to launch TimedTask.bat every time you want to make an entry to today's sheet 
    .EXAMPLE
    - Launch TimedTask.bat every time you want to record the time taken to perform a task. Only press "Enter" / "OK" once the task is complete.
    .EXAMPLE
	- Pin TimedTask.exe to the Taskbar. Then if a TimedTask is already launched, just right click on it to launch a new one
	.FUNCTIONALITY
    - version 1.1.2.4, added a search keword and some formatting
    - script now counts more than 60 min in version 1.1.2.3
    - TimedTask.ps1 version 1.1.2.1 autoupdates Category + TimedTask.exe (pinnable to taskbar)
    - TimedTask.ps1 based on Timesheet.ps1 but records beginning and end time instead. This is meant to be uses as launching a script for each tasks.
    - This version adds date-stamp to the generated .csv file
    - This version removes Type information in the generated .csv file (-NoTypeInformation)
    .NOTES
    - When editing in excel the double quotes generated by this script get removed for the csv > do not save the .csv after opening in Excel
    - no need to check if timesheet already existing as it is date-tagged
       Ideas for improvement:
    - need to bring windows to front when the script starts (and still be able to fade to background...)
	  
#>

#Requires -Version 5

#Time the script is launched at
$Start_Time = (Get-Date)

# Format today's date in the way that can be appended to a file name
$MyDate = (Get-Date).ToShortDateString().Replace('/', '_')

# Adding date to filename
$Filename = $MyDate + '_' + 'timesheet.csv'
$TSPath = Join-Path (Split-Path $profile) "$Filename"

class TSEntry {
  #region properties
  [datetime]$DateTime
  [string]$Duration
  [string]$Category
  [string]$Ticket
  [string]$Activity
  #endregion
	
  #region constructors
  TSEntry([datetime]$DateTime, [string]$Duration, [string]$Category, [string]$Ticket, [string]$Activity)
  {
    $this.DateTime = $DateTime
    $this.Duration = $Duration
    $this.Category = $Category
    $this.Ticket = $Ticket
    $this.Activity = $Activity
  }
  #endregion
	
  #region methods
	
  #endregion
}

function New-TSEntry
{
  Add-Type -AssemblyName Microsoft.VisualBasic # The input box object comes care of VisualBasic
	
  $TSPrompt = 'What are you working on?'
  $TSTitle = 'Timesheet'
  $TSDefault = ''
  $DefaultCategory = 'L3 Mentee Review'
  $TicketNumber = 'N/A'
  
  $entry = [Microsoft.VisualBasic.Interaction]::InputBox($TSPrompt, $TSTitle, $TSDefault)
	
  #Find if the typed entry contains a ticket number (7 or 8 digits, 7 if you miss to trype the leading 0)
  $entry -match '(?<ticket>(\d{7,8}))'
  if ($Matches){
    $TicketNumber = $Matches.ticket
  }
	
	
  $Log = New-Object PSObject	
  #Log object definition also defines in what order the objects will be displayed at the end.

  $Log | Add-Member NoteProperty Administration "$null"
  $Log | Add-Member NoteProperty Break "$null"
  $Log | Add-Member NoteProperty Chat "$null"
  $Log | Add-Member NoteProperty Development "$null"
  $Log | Add-Member NoteProperty DTS "$null"
  $Log | Add-Member NoteProperty Escalation "$null"
  $Log | Add-Member NoteProperty G2A "$null"
  $Log | Add-Member NoteProperty 'Inbound Call' "$null"
  $Log | Add-Member NoteProperty 'Internal Request' "$null"
  $Log | Add-Member NoteProperty 'L3 Mentee Review' "$null"
  $Log | Add-Member NoteProperty Management "$null"
  $Log | Add-Member NoteProperty Queue "$null"
  $Log | Add-Member NoteProperty Supervising "$null"
  $Log | Add-Member NoteProperty Training "$null"
	
  # key0 uses RegEx Expression Matching for key0 identifier. key1 is the PSObject Property Name. The order $A0 to $Axx also sets a priority list. Last in the list has priority for selecting the Category
  $A0 = @{ key0 = '(?<RegExMatch>(training))'; key1 = 'Training' } # Lowest priority Category
  $A1 = @{ key0 = '(?<RegExMatch>(break|lunch))'; key1 = 'Break' } # 
  $A2 = @{ key0 = '(?<RegExMatch>(Chat))'; key1 = 'Chat' } # 
  $A3 = @{ key0 = '(?<RegExMatch>(installed|editing|github|script|ps1))'; key1 = 'Development' } # 
  $A4 = @{ key0 = '(?<RegExMatch>(appointment|signing|login|updated|building|timesheet|One-on-One))'; key1 = 'Administration' } # 
  $A5 = @{ key0 = "(?<RegExMatch>(Skott|PR'ed| PR))"; key1 = 'L3 Mentee Review' } # 
  $A6 = @{ key0 = '(?<RegExMatch>(G2A))'; key1 = 'G2A' } # 
  $A7 = @{ key0 = '(?<RegExMatch>(DTS|FRN))'; key1 = 'DTS' } # 
  $A8 = @{ key0 = '(?<RegExMatch>(Shaun|Mathieu|internal|Kevin|Bloks|Bramley))'; key1 = 'Internal Request' } # 
  $A9 = @{ key0 = '(?<RegExMatch>(inbound|call))'; key1 = 'Inbound Call' } # 
  $A10 = @{ key0 = '(?<RegExMatch>(management))'; key1 = 'Management' } # 
  $A11 = @{ key0 = '(?<RegExMatch>(queue|articles))'; key1 = 'Queue' } # 
  $A12 = @{ key0 = '(?<RegExMatch>(meeting))'; key1 = 'Supervising' } # 
  $A13 = @{ key0 = '(?<RegExMatch>(escalation))'; key1 = 'Escalation' } # Highest priority Category
	
	
  #  $A14 = @{ key0 = '(?<RegExMatch>(\d{7,8}))'; key1 = 'TicketNumber' } # '(?<TicketNumber>(\d{7,8}))' matching format '01052582' or '1052582'
	
  $Keys = @(
    $A0,
    $A1,
    $A2,
    $A3,
    $A4,
    $A5,
    $A6,
    $A7,
    $A8,
    $A9,
    $A10,
    $A11,
    $A12,
    $A13
  )
	
  for ($counter = 0; $counter -lt $Keys.Length; $counter++)
  {
    # $Keys.Length > autoadjust if you add more identification keys
    # $consume consumes the result of the pipe since we are not directly interested by the pipe result but its side product from the $matches automatic variable and if true or false match for the conditional if loop
    $consume = $entry | Where-Object { $_ -imatch $Keys[$counter].key0 }
		
    # key2 Property (like AgentVersion, HostName, TaskName. This is the resulte of observer redundancies and size optimzation of the code
		
    if ($consume -notlike "$null")
    {
      $temp = $Keys[$counter].key1
      $Log."$temp" = $Matches.RegExMatch #this sotres the matched keywords in PSObject. Only for debugging
      $DefaultCategory = $Keys[$counter].key1
    }
  }
	
  # Calculate the duration of the task and returns in a mmmm.ss format (minutes . seconds format)
  [string]$CalculatedTaskDuration = '{0:n2}' -f ((Get-Date) - ($Start_Time)).TotalMinutes
	
  $result = [TSEntry]::new((Get-Date), $CalculatedTaskDuration, $DefaultCategory, $TicketNumber, $entry)
	
  # Creates a csv file with the Properties as header paramaters by default. If file already exist Export-Csv already only appends a new line / raw
  # Note: if the .csv is open in Excel, the entry will not be added (there might be an Excel option to allow for .csv to be overwritten, but better not open Excel until the end of the day)
  $result | Export-Csv -Path $TSPath -NoTypeInformation -Append
}
  # launch the class function creating a new csv and an entry to it
  New-TSEntry
