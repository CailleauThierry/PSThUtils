﻿<#
	.NOTES
	===========================================================================
	 Created on:   	Thursday November 10, 2016
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:		TimedTask.ps1
	 Started from: 	https://github.com/Windos/powershell-depot/blob/master/General/Timesheet.ps1
	===========================================================================
	.DESCRIPTION
		This is a simple .csv timesheet generation. Set to ask for time every 20 min since last time an entry was added
	.NOTES
		- TimedTask.ps1 based on Timesheet.ps1 but you record beginning and end time. This is meant to be uses as launching a script for each tasks
		- This version adds date-stamp to the generated .csv file
		- This version removes Type information in the generated .csv file (-NoTypeInformation)
		- This version add a start menu shortcut launch "Timesheet.ps1 - Shortcut" to place in either following directories:
			Autostart for currently logged-on user:
			shell:startup = %appdata%\Microsoft\Windows\Start Menu\Programs\Startup
			And startup folder all users:
			shell:common startup = %programdata%\Microsoft\Windows\Start Menu\Programs\Startup
		- "Timesheet.ps1 - Shortcut" is a shortcut of "Timesheet.ps1" editied to be an executable wrapper of the script
			This allows to avoid other tools dependencies on  bundling into an executable

	.EXAMPLE
		- copy "Timesheet.ps1 - Shortcut" to shell:startup
		- either double click on "Timesheet.ps1 - Shortcut" or restart your PC > in both case accept the pop-up asking you to allow powershell
#>

#Requires -Version 5

<#
	 Ideas for improvement:
		- have a way to enter text for the next pop-up
		- When editing in excel the double quotes generated by this script get removed for the csv
		- have the option to trigger a prompt box when needed
		- no need to check if timesheet already existing as it is date-tagged
		- need to add the next day as another column (manipulating object with import-csv?)
#>
#Time the script is launched at
$Start_Time = (Get-Date)

# Format today's date in the way that can be appended to a file name
$MyDate = (Get-Date).ToShortDateString().Replace("/", "_")

# Adding date to filename
$Filename = $MyDate + "_" + "timesheet.csv"
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
	
	$entry = [Microsoft.VisualBasic.Interaction]::InputBox($TSPrompt, $TSTitle, $TSDefault)
	# Calculate the duration of the task and returns in a mmmm.ss format (minutes . seconds format)
	[string]$CalculatedTaskDuration = "$(((Get-Date) - ($Start_Time)).Minutes)" + "." + "$(((Get-Date) - ($Start_Time)).Seconds)"
	$TicketNumber = "N/A"
	$DefaultCategory = "L3 Mentee Review"
	#Find if the typed entry contains a ticket number (7 or 8 digits, 7 if you miss to trype the leading 0)
	$entry -match '(?<ticket>(\d{7,8}))'
	if ($Matches){
		$TicketNumber = $Matches.ticket
	}
	
	$result = [TSEntry]::new((Get-Date), $CalculatedTaskDuration, $DefaultCategory, $TicketNumber, $entry)
	
<#	>> ((Get-Date) - ($Start_Time)) | gm
	
	
	TypeName: System.TimeSpan
	
	Name              MemberType Definition
	---- ---------- ----------
	Add               Method     timespan Add(timespan ts)
	CompareTo         Method     int CompareTo(System.Object value), int CompareTo(timespan value), int IComparable.CompareTo(System.Object obj), int IComparabl...
	Duration          Method     timespan Duration()
	Equals            Method     bool Equals(System.Object value), bool Equals(timespan obj), bool IEquatable[timespan].Equals(timespan other)
	GetHashCode       Method     int GetHashCode()
	GetType           Method     type GetType()
	Negate            Method     timespan Negate()
	Subtract          Method     timespan Subtract(timespan ts)
	ToString          Method     string ToString(), string ToString(string format), string ToString(string format, System.IFormatProvider formatProvider), strin...
	Days              Property   int Days { get; }
	Hours             Property   int Hours { get; }
	Milliseconds      Property   int Milliseconds { get; }
	Minutes           Property   int Minutes { get; }
	Seconds           Property   int Seconds { get; }
	Ticks             Property   long Ticks { get; }
	TotalDays         Property   double TotalDays { get; }
	TotalHours        Property   double TotalHours { get; }
	TotalMilliseconds Property   double TotalMilliseconds { get; }
	TotalMinutes      Property   double TotalMinutes { get; }
	TotalSeconds      Property   double TotalSeconds { get; }#>
	
<#	>> ((Get-Date) - ($Start_Time)).TotalMinutes | gm
	
	
	TypeName: System.Double
	
	Name        MemberType Definition
	---- ---------- ----------
	CompareTo   Method     int CompareTo(System.Object value), int CompareTo(double value), int IComparable.CompareTo(System.Object obj), int IComparable[double...
	Equals      Method     bool Equals(System.Object obj), bool Equals(double obj), bool IEquatable[double].Equals(double other)
	GetHashCode Method     int GetHashCode()
	GetType     Method     type GetType()
	GetTypeCode Method     System.TypeCode GetTypeCode(), System.TypeCode IConvertible.GetTypeCode()
	ToBoolean   Method     bool IConvertible.ToBoolean(System.IFormatProvider provider)
	ToByte      Method     byte IConvertible.ToByte(System.IFormatProvider provider)
	ToChar      Method     char IConvertible.ToChar(System.IFormatProvider provider)
	ToDateTime  Method     datetime IConvertible.ToDateTime(System.IFormatProvider provider)
	ToDecimal   Method     decimal IConvertible.ToDecimal(System.IFormatProvider provider)
	ToDouble    Method     double IConvertible.ToDouble(System.IFormatProvider provider)
	ToInt16     Method     int16 IConvertible.ToInt16(System.IFormatProvider provider)
	ToInt32     Method     int IConvertible.ToInt32(System.IFormatProvider provider)
	ToInt64     Method     long IConvertible.ToInt64(System.IFormatProvider provider)
	ToSByte     Method     sbyte IConvertible.ToSByte(System.IFormatProvider provider)
	ToSingle    Method     float IConvertible.ToSingle(System.IFormatProvider provider)
	ToString    Method     string ToString(), string ToString(string format), string ToString(System.IFormatProvider provider), string ToString(string format, S...
		ToType      Method     System.Object IConvertible.ToType(type conversionType, System.IFormatProvider provider)
		ToUInt16    Method     uint16 IConvertible.ToUInt16(System.IFormatProvider provider)
		ToUInt32    Method     uint32 IConvertible.ToUInt32(System.IFormatProvider provider)
		ToUInt64    Method     uint64 IConvertible.ToUInt64(System.IFormatProvider provider)#>
	
	# Creates a csv file with the Properties as header paramaters by default. If file already exist Export-Csv already only appends a new line / raw
	# Note: if the .csv is open in Excel, the entry will not be added (there might be an Excel option to allow for .csv to be overwritten, but better not open Excel until the end of the day)
	$result | Export-Csv -Path $TSPath -NoTypeInformation -Append
}
	# launch the class function creating a new csv and an entry to it
	New-TSEntry
