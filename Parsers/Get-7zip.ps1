Set-StrictMode -Version 2

function Invoke-SevenZip{
	<#
		.SYNOPSIS
			working Get-7ziz.ps1 based on working Get-7zip_PSW.ps1 

		.DESCRIPTION
			Takes an input archive full path througth Get-ChildItem Full_Path\*.extention
			
			#Could include a progress bar
			#Could be a Cmdlet
			Based on 7-Zip 9.20 64-bits
			
		.PARAMETER  ParameterA
			Expect a pipe parameter output of Cet-ChildItem.

		.EXAMPLE
			PS C:\Users\tcailleau\Documents> gci 'C:\Users\tcailleau\Documents\EMEA_files\Temp\006xxxxx\0062xxxx\00625330\Customer\DFC-VAULT.Customer.local-2015-01-30--15-55-33-825.zip' | Invoke-SevenZipPswd
			begin: This function expects a archive file like .tar .bz2 .bz .zip as a pipeline input Get-ChildItem Your_Path\*.bz2 ...

			7-Zip [64] 9.20  Copyright (c) 1999-2010 Igor Pavlov  2010-11-18

			Processing archive: C:\Users\tcailleau\Documents\EMEA_files\Temp\006xxxxx\0062xxxx\00625330\Customer\DFC-VAULT.Customer.local-2015-01-30--15-55-33-825.zip

			Extracting  app.csv
			[...]
			Extracting  vaultdb.bak

			Everything is Ok

			Folders: 6
			Files: 2113
			Size:       918073268
			Compressed: 201134797
			Output is: C:\Users\tcailleau\Documents\EMEA_files\Temp\006xxxxx\0062xxxx\00625330\Customer\DFC-VAULT.Customer.local-2015-01-30--15-55-33-825.zip  uncompressed or untared or 
			unarchived
			end: All is uncompressed or unarchive. This function return the created unarchive path:
			DFC-VAULT


		.EXAMPLE
			
			


		.INPUTS
			This function expects a archive file like .tar .bz2 .bz .zip as a pipeline input Get-ChildItem Your_Path\*.bz2 ...

		.OUTPUTS
			Returns the last processed achive name and creates a sub-direcotry "$_.Name.Split('.')[0]" to the Pipe i.e. to $_
			This allows to extract archives containing achives without having to identify the archive extension

		.NOTES
			Additional information about the function go here.

		.LINK
			about_functions_advanced

		.LINK
			about_comment_based_help

	#>
	begin {
		Write-OutPut "begin: This function expects a archive file like .tar .bz2 .bz .zip as a pipeline input Get-ChildItem Your_Path\*.bz2 ..."
		}
		process {
		# runs once per pipeline object pipeline object
		# here $_ represnets the archive file to uncompress, untar
		if (-not (test-path $Env:ProgramFiles\7-Zip\7z.exe)) {throw "$Env:ProgramFiles\7-Zip\7z.exe needed"}
		# this is a powershell invokation of the 7z.exe
		&"$Env:ProgramFiles\7-Zip\7z.exe" x $_ -aou ("-o" + $_.DirectoryName + '\' + $_.Name.Split('.')[0])
	
		Write-OutPut "Output is: $_  uncompressed or untared or unarchived"
		}
		end {
		Write-OutPut "end: This function uncompressed, untared or unarchived all to Your_Path\ subdirectories"
		return $_.Name.Split('.')[0]
	}
}

Clear-Host
