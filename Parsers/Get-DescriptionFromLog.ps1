﻿#requires -Version 2.0 -Modules Microsoft.PowerShell.Management
<#
	.SYNOPSIS
		Get-DescriptionFromLog.ps1 on 11/03/2017 version 1.0 is based on Get-EVVersion.ps1 revision 1.0 stable on 10/23/2017. 
    Detects if log to scan is either Agent or Vault log format and extract essential information for ticket documentation like:

    Working with:
    Vault Name IP or FQDN:
    Vault Version:
    Agent Name:
    Agent OS:
    Agent Version:
    Portal Version:
    Task Name:
	< 3rd Party App> Version:
	
	.DESCRIPTION
		Look at the date format to establish if the log is an Agent or a Vautl log (does not translate .xlog to text yet so you have to before using this script)
		Also could add multiple reccurence of the same entry in a different PropertyName
	.PARAMETER  
    [Parameter(mandatory=$true)][string] $InputFile
	.EXAMPLE. 
		Drag&Drop of the Agent log file to the script shotcut. It takes the full path from it

	.INPUTS
		Carbonite Agent or Vault backup/restore/synch logs in text format

	.OUTPUTS
		TypeName: System.Management.Automation.PSCustomObject > to the clipboard

	.NOTES
		Check this script version information in Get-DescriptionFromLog.history.zip (Automatically Generated by ISESteroids)

	.LINK
		about_comment_based_help

#>


param ( 
[Parameter(mandatory=$true,HelpMessage='Needs full path to file to parse')][string] $InputFile
)

# set Clipboard

. \Set-Clipboard_fc.ps1


# $log1 for Get-Content of it $log1 = Get-Content C:\hsgTest\input\Backup-526ABFBB-48AC-29B4.LOG

$Log = New-Object -TypeName PSObject
$Log | Add-Member -MemberType NoteProperty -Name "Log Name" 'Could not find a file name in Dragged & Dropped input'
$Log | Add-Member -MemberType NoteProperty -Name "Working with" "Did not capture customer\'s name"


#, vid=4e354d4a-4d7b-49d7-8c9d-11de84e19bff, cid=9c269aa4-ee11-491c-956e-b076a507719a, tid=96336c5c-4aff-4485-a3b0-ca2f31499484


$log1 = Get-Content $InputFile

# $Log."Log Path" and $Log."Log Name" are the first results coming out in that order at the end
$Log."Log Path" = $log1[1].PSPath
$Log."Log Name" = $log1[1].PSChildName
$Log."Working with" = ""

if (($log1[1]) -match '(^)((\d{2}-\w{3}-\d{4}\s))')
{
	# matching Vault 8.x log formating
	#Log object definition also defines in what order the objects will be displayed at the end
	$Log | Add-Member -MemberType NoteProperty -Name "Vault Name or IP" 'Vault Name IP or FQDN'
	$Log | Add-Member -MemberType NoteProperty -Name "Vault Version" 'No Vault version Available in this log'
	$Log | Add-Member -MemberType NoteProperty -Name "Agent Host Name" 'Could not find a Agent host name'
	$Log | Add-Member -MemberType NoteProperty -Name "Agent OS" 'Could not find an Agent OS from log'
	$Log | Add-Member -MemberType NoteProperty -Name "Agent Version" 'No Agent version Available in this log'
	$Log | Add-Member -MemberType NoteProperty -Name "Portal Version" 'Did not get Portal Version'
	$Log | Add-Member -MemberType NoteProperty -Name "Task Name" 'Could not find a task name'
	$Log | Add-Member -MemberType NoteProperty -Name "3rd Party App Version" 'Did not find other components version'
	$Log | Add-Member -MemberType NoteProperty -Name "Log End Time" 'Could not find a valid time format for a Vault 7 log in text format'

	# key0 : line identifier key1 : RegEx Expression Matching for key0 identifier key2 is the PSObject Property Name associated with key0 identifier
	$A0 = @{key0 = ' Vault: ';key1 = '( Vault: )(?<RegExMatch>(.*))';key2 = 'Vault Name or IP'} 
	$A1 = @{key0 = '-I-0219';key1 = '(\s)(?<RegExMatch>(\d{1}\.\d{2}))';key2 = 'Vault Version'}  							 
	$A2 = @{key0 = 'hn =';key1 = '(hn = )(?<RegExMatch>(.*?))($)';key2 = 'Agent Host Name'} 									 
	$A3 = @{key0 = '';key1 = '';key2 = 'Agent OS'}   
	$A4 = @{key0 = '-I-0354';key1 = '(\<)(?<RegExMatch>(\d{1}\.\d{2}\.\d{4}))';key2 = 'Agent Version'}  					
	$A5 = @{key0 = ' tn = ';key1 = '(tn = )(?<RegExMatch>(.*))';key2 = 'Task Name'}											
	$A6 = @{key0 = '';key1 = '';key2 = '3rd Party App Version'}						
	$A7 = @{key0 = ' tid=';key1 = '(tid= )(?<RegExMatch>(\w{8}-\w{4}-\w{4}-\w{4}-\w{12}))';key2 = 'Task GUID'}
	$A8 = @{key0 = '(^)(\d{2}-\w{3}-\d{4})';key1 = '(^)(?<RegExMatch>(\d{2}-\w{3}-\d{4}\s\d{2}:\d{2}:\d{2}))';key2 = 'Log End Time'}  
	}

elseif (($log1[1]) -match '(^)(\w{3}\d{2})')
{
	# matching Vault 7.11 log formating
	#Log object definition also defines in what order the objects will be displayed at the end
	$Log | Add-Member -MemberType NoteProperty -Name "Vault Name or IP" 'Vault Name IP or FQDN'
	$Log | Add-Member -MemberType NoteProperty -Name "Vault Version" 'No Vault version Available in this log'
	$Log | Add-Member -MemberType NoteProperty -Name "Agent Host Name" 'Could not find a Agent host name'
	$Log | Add-Member -MemberType NoteProperty -Name "Agent OS" 'Could not find an Agent OS from log'
	$Log | Add-Member -MemberType NoteProperty -Name "Agent Version" 'No Agent version Available in this log'
	$Log | Add-Member -MemberType NoteProperty -Name "Portal Version" 'Did not get Portal Version'
	$Log | Add-Member -MemberType NoteProperty -Name "Task Name" 'Could not find a task name'
	$Log | Add-Member -MemberType NoteProperty -Name "3rd Party App Version" 'Did not find other components version'
	$Log | Add-Member -MemberType NoteProperty -Name "Log End Time" 'Could not find a valid time format for a Vault 7 log in text format'

	
	# key0 : line identifier key1 : RegEx Expression Matching for key0 identifier key2 is the PSObject Property Name associated with key0 identifier
	$A0 = @{key0 = ' Vault: ';key1 = '( Vault: )(?<RegExMatch>(.*))';key2 = 'Vault Name or IP'} 
	$A1 = @{key0 = '-I-0219';key1 = '(\s)(?<RegExMatch>(\d{1}\.\d{2}))';key2 = 'Vault Version'}  							# changed keyword " Vault Version" to " BKUP-I-04315" as in French it would Be "Version du vault" , note sub-filtering by ault As vault in english is upppercase V 
	$A2 = @{key0 = 'hn =';key1 = '(hn = )(?<RegExMatch>(.*?))($)';key2 = 'Agent Host Name'} 										# '(hn =)(?<RegExMatch>(.*?))($)' matching format 'hn = 1_host_name  
	$A3 = @{key0 = '';key1 = '';key2 = 'Agent OS'}   
	$A4 = @{key0 = '-I-0354';key1 = '(\<)(?<RegExMatch>(\d{1}\.\d{2}\.\d{4}))';key2 = 'Agent Version'}  					# '(\<)(?<RegExMatch>(\d{1}\.\d{2}\.\d{4}))' matching format 'VVLT-I-0354 Agent version is <7.50.6422>'
	$A5 = @{key0 = ' tn = ';key1 = '(tn = )(?<RegExMatch>(.*))';key2 = 'Task Name'}											# '(tn = )(?<RegExMatch>(.*))' matching format 'tn = 1_task_name'
	$A6 = @{key0 = '';key1 = '';key2 = '3rd Party App Version'}						
	$A7 = @{key0 = ' tid=';key1 = '(tid= )(?<RegExMatch>(\w{8}-\w{4}-\w{4}-\w{4}-\w{12}))';key2 = 'Task GUID'}
	$A8 = @{key0 = '(^)(\w{3}\d{2})';key1 = '(^)(?<RegExMatch>(\w{3,4}\d{2}\s\d{2}:\d{2}:\d{2}))';key2 = 'Log End Time'}  	# '(^)(?<RegExMatch>(\w{3,4}\d{2}\s\d{2}:\d{2}:\d{2}))' matching format 'May22 21:19:03'				# there is no "," at the end of the first cid
	}

elseif (($log1[1]) -match '(^)((\d{2}-\w{3}\s))')
{
	# matching Agent 7.x and 8.x log formating
	#Log object definition also defines in what order the objects will be displayed at the end
	$Log | Add-Member -MemberType NoteProperty -Name "Vault Name or IP" 'Vault Name IP or FQDN'
	$Log | Add-Member -MemberType NoteProperty -Name "Vault Version" 'No Vault version Available in this log'
	$Log | Add-Member -MemberType NoteProperty -Name "Agent Host Name" 'Could not find a Agent host name'
	$Log | Add-Member -MemberType NoteProperty -Name "Agent OS" 'Could not find an Agent OS'
	$Log | Add-Member -MemberType NoteProperty -Name "Agent Version" 'No Agent version Available in this log'
	$Log | Add-Member -MemberType NoteProperty -Name "Portal Version" 'Did not get Portal Version'
	$Log | Add-Member -MemberType NoteProperty -Name "Task Name" 'Could not find a task name'
	$Log | Add-Member -MemberType NoteProperty -Name "3rd Party App Version" 'Did not find other components version'
	$Log | Add-Member -MemberType NoteProperty -Name "Log End Time" 'Could not find a valid time format for an Agent log in text format'
	
	
	# key0 : line identifier key1 : RegEx Expression Matching for key0 identifier key2 is the PSObject Property Name associated with key0 identifier
	$A0 = @{key0 = '-I-04746.';key1 = '(SSET-I-04746.*\s)(?<RegExMatch>(.*)),';key2 = 'Vault Name or IP'}  
	$A1 = @{key0 = '-I-04315';key1 = '(\s)(?<RegExMatch>(\d{1}\.\d{2}))';key2 = 'Vault Version'}   						
	$A2 = @{key0 = ' hn=';key1 =  '(hn=)(?<RegExMatch>(.*?))[,\s]\s*';key2 = 'Agent Host Name'} 								
	$A3 = @{key0 = ' NT \d{1}';key1 = '(Windows )(?<RegExMatch>(NT\s\d{1,2}\.\d{1}))';key2 = 'Agent OS'} 										
	$A4 = @{key0 = '-I-04314';key1 = '(\s)(?<RegExMatch>(\d{1}\.\d{2}\.\d{4}))';key2 = 'Agent Version'} 				
	$A5 = @{key0 = '';key1 = '';key2 = 'Portal Version'}
	$A6 = @{key0 = ' tn=';key1 =  '(tn=)(?<RegExMatch>(.*?))[,\s]\s*';key2 = 'Task Name'}					
	$A7 = @{key0 = '';key1 = '';key2 = '3rd Party App Version'}
	$A8 = @{key0 = '(^)((\d{2}-\w{3}))';key1 = '(^)(?<RegExMatch>(\d{2}-\w{3,4}\s\d{2}:\d{2}:\d{2}))';key2 = 'Log End Time'} 
	} 
	else
	{
		# no Carbonite logs match were found
		#Log object definition also defines in what order the objects will be displayed at the end
		$Log | Add-Member -MemberType NoteProperty -Name "Vault Name or IP" 'Not found. Is this a valid log in text format?'
		$Log | Add-Member -MemberType NoteProperty -Name "Vault Version" 'Not found. Is this a valid log in text format?'
		$Log | Add-Member -MemberType NoteProperty -Name "Agent Host Name" 'Not found. Is this a valid log in text format?'
		$Log | Add-Member -MemberType NoteProperty -Name "Agent OS" 'Not found. Is this a valid log in text format?'
		$Log | Add-Member -MemberType NoteProperty -Name "Agent Version" 'Not found. Is this a valid log in text format?'
		$Log | Add-Member -MemberType NoteProperty -Name "Portal Version" 'Not found. Is this a valid log in text format?'
		$Log | Add-Member -MemberType NoteProperty -Name "Task Name" 'Not found. Is this a valid log in text format?'
		$Log | Add-Member -MemberType NoteProperty -Name "3rd Party App Version" 'Not found. Is this a valid log in text format?'
		$Log | Add-Member -MemberType NoteProperty -Name "Log End Time" 'Not found. Is this a valid log in text format?'
		}

$Keys = @(
$A0,
$A1,
$A2,
$A3,
$A4,
$A5,
$A6,
$A7,
$A8
)

for($counter = 0; $counter -lt $Keys.Length; $counter++){
    # $Keys.Length > autoadjust if you add more identification keys
	# $consume consumes the result of the pipe since we are not directly interested by the pipe result but its side product from the $matches automatic variable and if true or false match for the conditional if loop
	$consume = $log1 | Where-Object {$_ -match $Keys[$counter].key0 } | Where-Object {$_ -match  $Keys[$counter].key1}

# key2 Property (like "Agent Version", "Agent Host Name", "Task Name". This is the resulte of observer redundancies and size optimzation of the code

if ($consume -notlike $null) {
	$Log.($Keys[$counter].key2) = $Matches[2]
	}

}

if ($Log."Agent OS" -match 'NT \d{1,2}\.\d{1}') {
	$Log."Agent OS" = {Switch -Regex ($Log."Agent OS") {
		"NT 5\.0" {'Windows 2000';Break}
		"NT 5\.1" {'Windows XP';Break}
		"NT 5\.2" {'Windows Server 2003 or Windows Server 2003 R2';Break}
		"NT 6\.0" {'Windows Server 2008';Break}
		"NT 6\.1" {'Windows 7 or Windows Server 2008 R2 or Windows Home Server 2011';Break}
		"NT 6\.2"  {'Windows 8 or Windows Server 2012';Break}
		"NT 6\.3"  {'Windows 8.1 or Windows Server 2012 R2 ';Break}
		"NT 10\.0" {'Windows 10 or Windows Server 2016';Break}
		Default {'Could not detect Agent OS'}
	}}.InvokeReturnAsIs()
}

# Use case
$Log | Out-File .\result.txt -Force
Get-Content .\result.txt | Select-Object -Skip 2 | Set-Clipboard
Get-Item .\result.txt | Remove-Item

#Once pasted from clipboard the result is:
#
#
# "Log Path"           : C:\Users\tcailleau\Documents\WindowsPowerShell\TestExamples\Agent\7.22_NT_6.2.log
# "Log Name"           : 7.22_NT_6.2.log
# "Log End Time"        : 19-Sep 09:31:36
# "Agent Version"      : 7.22.2211
# "Vault Version"      : 8.00
# "Agent Host Name"     : Host1
# "Agent IP Address"         : 11.222.333.44
# "Task Name"          : SQL_DEFAULT
# "Safeset Number"     : 13446
# "Task GUID"          : 75ab113b-9611-4a4e-a0f1-22a7a8cf16d3
# "Agent OS"           : Windows 8 or Windows Server 2012
# "Vault Name or IP" : VaultName1




