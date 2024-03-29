function Get-EVTX{
	<#
		.SYNOPSIS
			 working Get-EVTX.ps1 Converts a .evtx file into a Text readable.log file 

		.DESCRIPTION
			Takes an input archive full path througth Get-ChildItem Full_Path\
			Assumes you have a supporting version of a Windows Agent to open any .evtx file from any other Agent types (not tested with iseries Agent .evtx files)

		.EXAMPLE
			PS> Get-ChildItem C:\Temp\05xxxxxx -Filter *.evtx -Recurse | Get-EVTX
			Detects all .evtx file in provided folder a all subfolders and translates them to text files with a .log extension

		.INPUTS
			This function expects "Get-ChildItem <DriectoryPath> -Filter *.evtx -Recurse" as a pipe input tio the function Get-EVTX

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
    Write-OutPut "begin: This function expects a folder containing .evtx files ..."
	}
	process {
	# runs once per pipeline object pipeline object
	# here $_ represents the files found in that direcotry


	Write-Host "Processing conversion... ...please wait this could take a while"
	# this works from CLI: PS C:\Program Files\Carbonite Server Backup\Agent> &'C:\Program Files\Carbonite Server Backup\Agent\vv.exe' `$DTACHECK /source=C:\Temp\05xxxxxx\05170418\00000053_1563186491.evtx /format=dump

	$FullFilePath = $_.FullName
	$ConvertedFile = "$FullFilePath" + "_PassThruSelection.log"
	

	Get-WinEvent -Path $FullFilePath -MaxEvents 20000 | 
	Select-Object * | 
	Out-GridView -PassThru | 
	Out-File $ConvertedFile

	Write-Host "Conversion complete"

	Write-OutPut "Output is: $ConvertedFile Source was $_ Directory was $FullFilePath)"
	}
	end {
	Write-OutPut "end: All is converted"
	}
}
Clear-Host
