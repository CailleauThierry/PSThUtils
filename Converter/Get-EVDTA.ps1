function GET-EVDTA{
	<#
		.SYNOPSIS
			 working Get-EVDTA.ps1 Converts a .DTA file into a Text readable.log file 

		.DESCRIPTION
			Takes an input archive full path througth Get-ChildItem Full_Path\
			Assumes you have a supporting version of a Windows Agent to open any .DTA file from any other Agent types (not tested with iseries Agent .DTA files)

		.EXAMPLE
			PS> Get-ChildItem C:\Temp\05xxxxxx -Filter *.DTA -Recurse | GET-EVDTA
			Detects all .DTA file in provided folder a all subfolders and translates them to text files with a .log extension

		.INPUTS
			This function expects "Get-ChildItem <DriectoryPath> -Filter *.DTA -Recurse" as a pipe input tio the function GET-EVDTA

		.OUTPUTS
			Returns nothing

		.NOTES
			This runs successfully on PS 5.1 as soon as ISE is ran as administrator

		.LINK
			about_functions_advanced

		.LINK
			about_comment_based_help

	#>
	begin {
    Write-OutPut "begin: This function expects a folder containing .DTA files ..."
	$InstalledAgentPath = (Get-Item HKLM:\Software\EVault\InfoStage\Agent).GetValue("ClientDataDir")
	$VVexePath = "$InstalledAgentPath"+"vv.exe"
	}
	process {
	# runs once per pipeline object pipeline object
	# here $_ represents the files found in that direcotry
	if (-not (test-path "$VVexePath")) {throw "$VVexePath is needed"}

	Write-Host "Processing conversion... ...please wait this could take a while"
	
	$Path = $_.Directory
	$FullFilePath = "$Path" + "\" + $_
	$ConvertedFile = "$FullFilePath" + ".log"
	&($VVexePath) `$DTACHECK `/source`=$FullFilePath `/format`=dump > $ConvertedFile

	Write-Host "Conversion complete"

	Write-OutPut "Output is: $ConvertedFile Source was $_ Directory was $FullFilePath)"
	}
	end {
	Write-OutPut "end: All is converted"
	}
}
Clear-Host
