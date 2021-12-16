<#
	.SYNOPSIS
		Invoke-CsvEvtx2TxtErrWg.ps1 based on Invoke-CSV_EVTX2TxtErrWg_03.ps1 allwoing to filter out cluter messages

	.DESCRIPTION
	    Takes any *.csv or *.evtx files and filters Warning and errors out of them for at least the past year


	.PARAMETER  ParameterA
		The description of the ParameterA parameter.

	.PARAMETER  ParameterB
		The description of the ParameterB parameter.

	.EXAMPLE
		PS C:\> Get-Something -ParameterA 'One value' -ParameterB 32

	.EXAMPLE
		PS C:\> Get-Something 'One value' 32

	.INPUTS
		System.String,System.Int32

	.OUTPUTS
		System.String

	.NOTES
		Additional information about the function go here.

	.LINK
		about_functions_advanced

	.LINK
		about_comment_based_help

#>


param ( 
[Parameter(mandatory=$true)] [string]$CsvEvtxFullName
)
		
$filename = ($CsvEvtxFullName).Split('\\')[-1]
$filedirectory =  $CsvEvtxFullName.TrimEnd("$filename")


$lastyear = (get-date).AddMonths(-12).Year

if (($filename) -like "*.csv")
{
	Write-Host "Filtering: `n $CsvEvtxFullName"

	Get-ChildItem $CsvEvtxFullName | ForEach-Object { 		
		Write-Output "Application Event Errors and Warnings--------------------------------------------------------------------------------------------------------------------------------" | Out-File ("$filedirectory" + "$filename" + "_filtered.log") -NoClobber
		Import-Csv $CsvEvtxFullName | where {$_.'Date and Time'.Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"}  | where {($_.LevelDisplayName -like "Error" -or $_.LevelDisplayName -like "Warning") -and ($_.Message -notmatch ".*OneNote.*|.*CutePDF.*|.*Xerox.*|.*LaserJet.*|.*Microsoft XPS.*|.*printer.*")}  | Out-File ("$filedirectory" + "$filename" + "_filtered.log") -Append
	Write-Host "Filtered to:"
	Write-Host ("$filedirectory" + "$filename" + "_filtered.log").ToString()
	}
}
 
elseif(($filename) -like "*.evtx")
{ 
	Write-Host "Filtering: `n $CsvEvtxFullName"
	$GWEAppEvtx = Get-WinEvent -Path $CsvEvtxFullName
	Write-Output "Event Errors or Warnings ---------------------------------------------------------------------------------------------------------------------------------" | Out-File  ("$filedirectory" + "$filename" + "_filtered.log") -NoClobber
	$GWEAppEvtx | where {$_.TimeCreated.ToString().Replace('-'," ").Replace('/',' ').Split(" ")[2] -ge "$lastyear"} | where {($_.LevelDisplayName -like "Error" -or $_.LevelDisplayName -like "Warning") -and ($_.Message -notmatch ".*OneNote.*|.*CutePDF.*|.*Xerox.*|.*LaserJet.*|.*Microsoft XPS.*|.*printer.*")}   |  Format-List -Property LevelDisplayName,TimeCreated,ProviderName,Id,Keywords,ProcessId,MachineName,UserId,Message  | Out-File  ("$filedirectory" + "$filename" + "_filtered.log") -Width 300 -Append
	Write-Host "Filtered to:"
	Write-Host ("$filedirectory" + "$filename" + "_filtered.log").ToString()
	
}

else
{
Write-Host "$filename was not a *.csv or *.evtx file"
}


