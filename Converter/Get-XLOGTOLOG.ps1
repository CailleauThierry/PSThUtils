Set-StrictMode -Version 2

function GET-XLOGTOLOG{
	<#
		.SYNOPSIS
			working GET-XLOGTOLOG.ps1 Converts a .XLOG file into a Text readable.log file

		.DESCRIPTION
			Takes an input archive full path througth Get-ChildItem Full_Path\
			Assumes you have a supporting version of a Windows Agent to open any .XLOG file from any other Agent types (not tested with iseries Agent .XLOG files)

		.EXAMPLE
			PS> Get-ChildItem C:\Temp\05xxxxxx -Filter *.XLOG -Recurse | GET-XLOGTOLOG
			Detects all .XLOG file in provided folder a all subfolders and translates them to text files with a .log extension

		.INPUTS
			This function expects "Get-ChildItem <DriectoryPath> -Filter *.XLOG -Recurse" as a pipe input tio the function GET-XLOGTOLOG

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
    Write-OutPut "begin: This function expects a folder containing .XLOG files ..."
	}
	process {
	# runs once per pipeline object pipeline object
	# here $_ represents the files found in that direcotry
	if (-not (test-path "$Env:ProgramFiles\Carbonite Server Backup\Agent\XLogTranslator.exe")) {throw "\$Env:ProgramFiles\Carbonite Server Backup\Agent\XLogTranslator.exe needed"}

	Write-Host "Processing conversion... ...please wait this could take a while"

	&(($Env:ProgramFiles) + "\Carbonite Server Backup\Agent\XLogTranslator.exe") $_ /o "$_.log"

	Write-Host "Conversion complete"

	Write-OutPut "Output is: $_.log Source was $_ Directory was $_.Direcotry)"
	}
	end {
	Write-OutPut "end: All is converted"
	}
}
Clear-Host
# Get-ChildItem *.xlog -Filter *.xlog -Recurse | Select-Object {$_.FullName} | GET-XLOGTOLOG