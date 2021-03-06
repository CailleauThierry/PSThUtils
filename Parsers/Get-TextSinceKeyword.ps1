

# Get-TextSinceKeyword.ps1

. .\Get-Clipboard_fc.ps1
. .\Set-Clipboard_fc.ps1
$SetClipNull = $null

#$log1 = Get-Content $InputFile



$Log = New-Object PSObject




$SetClipNull | Set-Clipboard


if (($log1[1]) -match '(^)((\d{2}\-\w{3}))')
{
# matching Agent 7.x log formating
#Log object definition also defines in what order the objects will be displayed at the end
$Log | Add-Member NoteProperty LogEndTime "Could not find a valid time format for an Agent log in text format"
$Log | Add-Member NoteProperty AgentVersion "No Agent version Available in this log"
$Log | Add-Member NoteProperty VaultVersion "No Vault version Available in this log"
$Log | Add-Member NoteProperty HostName "Could not find a Host name"
$Log | Add-Member NoteProperty IPAddress "Could not find a IP Address"
$Log | Add-Member NoteProperty TaskName "Could not find a task name"
$Log | Add-Member NoteProperty CatalogNumber "Could not find a CatalogNumber number" 
$Log | Add-Member NoteProperty TaskGUID "Could not find a Task GUID"
$Log | Add-Member NoteProperty AgentGUID "Could not find an Agent GUID"
$Log | Add-Member NoteProperty VaultGUID "Could not find a Vault GUID"

# key0 : line identifier key1 : RegEx Expression Matching for key0 identifier key2 is the PSObject Property Name associated with key0 identifier
$A0 = @{key0 = '(^)((\d{2}\-\w{3}))';key1 = '(^)(?<RegExMatch>(\d{2}\-\w{3,4}\s\d{2}:\d{2}:\d{2}))';key2 = "LogEndTime"}  	# '(^)(?<RegExMatch>(\d{2}\-\w{3}\s\d{2}:\d{2}:\d{2}))' matching format '04-Dec 21:30:02'
$A1 = @{key0 = "\-I\-04314";key1 = '(\s)(?<RegExMatch>(\d{1}\.\d{2}\.\d{4}))';key2 = "AgentVersion"}  						# " BKUP-I-04314" same code as" REST-I-04314" so chnaging it to "-I-04314" only
$A2 = @{key0 = "\-I\-04315";key1 = '(\s)(?<RegExMatch>(\d{1}\.\d{2}))';key2 = "VaultVersion"}  								# changed keyword " Vault Version" to " BKUP-I-04315" as in French it would Be "Version du vault" , note sub-filtering by ault As vault in english is upppercase V
$A3 = @{key0 =  " hn=";key1 =  '(hn=)(?<RegExMatch>(.*?))[,\s]\s*';key2 = "HostName"} 										# RegEx tested on http://rubular.com/ (.*?) where "?" means relunctant (matches only once) as oppose to greedy. See http://groovy.codehaus.org/Tutorial+5+-+Capturing+regex+groups> 
$A4 = @{key0 =  " ip=";key1 = '(ip=)(?<RegExMatch>(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}))';key2 = "IPAddress"} 				# '(ip=)' is not needed here but it looks consistent with previous (hn=)
$A5 = @{key0 =  " tn=";key1 =  '(tn=)(?<RegExMatch>(.*?))[,\s]\s*';key2 = "TaskName"}
$A6 = @{key0 =  "\-I\-04133";key1 = '((([\s](\w*)){4})[\s])(?<RegExMatch>(\d+))';key2 = "CatalogNumber"}					# '\-I\-04133[\s].*)(?<RegExMatch>([\s]\d+))' matching format  '-I-04132 synching catalog number is XXX' in any languages
$A7 = @{key0 = " tid=";key1 = '(tid=)(?<RegExMatch>(\w{8}\-\w{4}\-\w{4}\-\w{4}\-\w{12}))';key2 = "TaskGUID"}
$A8 = @{key0 = " cid=";key1 = '(cid=)(?<RegExMatch>(\w{8}\-\w{4}\-\w{4}\-\w{4}\-\w{12}))';key2 = "AgentGUID"}  				# there is no "," at the end of the first cid
$A9 = @{key0 = " vid=";key1 = '(vid=)(?<RegExMatch>(\w{8}\-\w{4}\-\w{4}\-\w{4}\-\w{12}))';key2 = "VaultGUID"}  				# since guid are a set format, I do not need to match the "," at the end

# This $Keys Stores Array entries (slightly different from HashTables or Herestrings in PowerShell)
# It is directly responsible for the number of time this script parses the same logs, here stored in variable $log1

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
$A9
)
} 
else
{
# matching Vault 7.11 log formating
#Log object definition also defines in what order the objects will be displayed at the end
$Log | Add-Member NoteProperty LogEndTime "Could not find a valid time format for an Agent log in text format"
$Log | Add-Member NoteProperty AgentVersion "No Agent version Available in this log"
$Log | Add-Member NoteProperty VaultVersion "No Vault version Available in this log"
$Log | Add-Member NoteProperty HostName "Could not find a Host name"
$Log | Add-Member NoteProperty IPAddress "Could not find a IP Address"
$Log | Add-Member NoteProperty TaskName "Could not find a task name"
$Log | Add-Member NoteProperty CatalogNumber "Could not find a CatalogNumber number" 
$Log | Add-Member NoteProperty TaskNumber "Could not find a TaskNumber number" # This Vault specific additional parameter is the reason why we have 2 definitions og $Log's parameters
$Log | Add-Member NoteProperty TaskGUID "Could not find a Task GUID"
$Log | Add-Member NoteProperty AgentGUID "Could not find an Agent GUID"
$Log | Add-Member NoteProperty VaultGUID "Could not find a Vault GUID"

# key0 : line identifier key1 : RegEx Expression Matching for key0 identifier key2 is the PSObject Property Name associated with key0 identifier
$A0 = @{key0 = '(^)(\w{3}\d{2})';key1 = '(^)(?<RegExMatch>(\w{3,4}\d{2}\s\d{2}:\d{2}:\d{2}))';key2 = "LogEndTime"}  	# '(^)(?<RegExMatch>(\w{3,4}\d{2}\s\d{2}:\d{2}:\d{2}))' matching format 'May22 21:19:03'
$A1 = @{key0 = "\-I\-0354";key1 = '(\<)(?<RegExMatch>(\d{1}\.\d{2}\.\d{4}))';key2 = "AgentVersion"}  					# '(\<)(?<RegExMatch>(\d{1}\.\d{2}\.\d{4}))' matching format 'VVLT-I-0354 Agent version is <7.50.6422>'
$A2 = @{key0 = "\-I\-0219";key1 = '(\s)(?<RegExMatch>(\d{1}\.\d{2}))';key2 = "VaultVersion"}  							# changed keyword " Vault Version" to " BKUP-I-04315" as in French it would Be "Version du vault" , note sub-filtering by ault As vault in english is upppercase V
$A3 = @{key0 =  "hn =";key1 = '(hn = )(?<RegExMatch>(.*?))($)';key2 = "HostName"} 										# '(hn =)(?<RegExMatch>(.*?))($)' matching format 'hn = 1_host_name 
$A4 = @{key0 =  "ip =";key1 = '(ip = )(?<RegExMatch>(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}))';key2 = "IPAddress"} 			# '(ip=)' is not needed here but it looks consistent with previous (hn=)
$A5 = @{key0 =  " tn = ";key1 = '(tn = )(?<RegExMatch>(.*))';key2 = "TaskName"}											# '(tn = )(?<RegExMatch>(.*))' matching format 'tn = 1_task_name'
$A6 = @{key0 =  "\-I\-0037";key1 = '((([\s](\w*)){4})[\s])(?<RegExMatch>(\d+))';key2 = "CatalogNumber"}					# '\-I\-04133[\s].*)(?<RegExMatch>([\s]\d+))' matching format  '-I-04132 synching catalog number is XXX' in any languages
$A7 = @{key0 =  " tid= ";key1 = '(tid= .*  \()(?<RegExMatch>([\d]{1,3}))';key2 = "TaskNumber"}							# '(tid= .*  \()(?<RegExMatch>([\d]{1,3}))' matching format 'tid= e69994fd-fd03-4a15-b645-0c7097760595  (2)' by counting 1 "single space" i.e '[\s]' and then 2 single space i.e. [\s]{2} then checking for opening parentheses '\('  where '.*' stands for "anycharacters in between"
$A8 = @{key0 = " tid=";key1 = '(tid= )(?<RegExMatch>(\w{8}\-\w{4}\-\w{4}\-\w{4}\-\w{12}))';key2 = "TaskGUID"}
$A9 = @{key0 = " cid=";key1 = '(cid= )(?<RegExMatch>(\w{8}\-\w{4}\-\w{4}\-\w{4}\-\w{12}))';key2 = "AgentGUID"}  				# there is no "," at the end of the first cid
$A10 = @{key0 = " vid=";key1 = '(vid= )(?<RegExMatch>(\w{8}\-\w{4}\-\w{4}\-\w{4}\-\w{12}))';key2 = "VaultGUID"}  				# since guid are a set format, I do not need to match the "," at the end

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
$A10
)

}



for($counter = 0; $counter -lt $Keys.Length; $counter++){
    # $Keys.Length > autoadjust if you add more identification keys
	# $consume consumes the result of the pipe since we are not directly interested by the pipe result but its side product from the $matches automatic variable and if true or false match for the conditional if loop
	$consume = $log1 | Where-Object {$_ -match $Keys[$counter].key0 } | Where-Object {$_ -match  $Keys[$counter].key1}

# key2 Property (like AgentVersion, HostName, TaskName. This is the resulte of observer redundancies and size optimzation of the code

if ($consume -notlike $null) {
		$temp = $Keys[$counter].key2
		$Log."$temp" = $Matches[2]
}

}


$field = $ie.Document.getElementsByName('00NF000000DEXp8_ileinner')

$field.text = $Log.HostName.ToString()

#$field = $ie.Document.getElementById("00NF000000DEXp8_ileinner")
#$field.textContent = $Log.HostName.ToString()
##$field = $ie.Document.getElementById("00NF000000DEHUZ_ileinner")
##$field.textContent = $Log.Platform.ToString()
#$field = $ie.Document.getElementById("00NF000000DEXpD_ileinner")
#$field.textContent = $Log.TaskName.ToString()
#