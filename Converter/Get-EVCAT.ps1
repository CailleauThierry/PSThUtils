Set-StrictMode -Version 2

function GET-EVCAT{
	<#
		.SYNOPSIS
			working Get-EVCAT.ps1 Converts a .CAT file into a Text readable.log file

		.DESCRIPTION
			Takes an input archive full path througth Get-ChildItem Full_Path\
			Assumes you have a supporting version of a Windows Agent to open any .CAT file from any other Agent types (not tested with iseries Agent .CAT files)

		.EXAMPLE
			PS> Get-ChildItem C:\Temp\05xxxxxx -Filter *.CAT -Recurse | GET-EVCAT
			Detects all .CAT file in provided folder a all subfolders and translates them to text files with a .log extension

		.INPUTS
			This function expects "Get-ChildItem <DriectoryPath> -Filter *.CAT -Recurse" as a pipe input tio the function GET-EVCAT

		.OUTPUTS
			Returns nothing

		.NOTES
			Additional information about the function go here.

		.LINK
			about_functions_advanced

		.LINK
			about_comment_based_help

	#>
	begin {
    Write-OutPut "begin: This function expects a folder containing .CAT files ..."
	}
	process {
	# runs once per pipeline object pipeline object
	# here $_ represents the files found in that direcotry
	if (-not (test-path "$Env:ProgramFiles\Carbonite Server Backup\Agent\vv.exe")) {throw "\$Env:ProgramFiles\Carbonite Server Backup\Agent\vv.exe needed"}

	Write-Host "Processing conversion... ...please wait this could take a while"
	# this works from CLI: PS C:\Program Files\Carbonite Server Backup\Agent> &'C:\Program Files\Carbonite Server Backup\Agent\vv.exe' `$CATCHECK /source=C:\Temp\05xxxxxx\05170418\00000053_1563186491.CAT /full

	$Path = $_.Directory
	$FullFilePath = "$Path" + "\" + $_
	$ConvertedFile = "$FullFilePath" + ".log"
	&(($Env:ProgramFiles) + "\Carbonite Server Backup\Agent\vv.exe") `$CATCHECK `/source`=$FullFilePath `/full > $ConvertedFile

	Write-Host "Conversion complete"

	Write-OutPut "Output is: $ConvertedFile Source was $_ Directory was $FullFilePath)"
	}
	end {
	Write-OutPut "end: All is converted"
	}
}
Clear-Host
