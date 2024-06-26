Set-StrictMode -Version 2

function Invoke-SevenZipPswdCMAFCMsInfo{
	<#
		.SYNOPSIS
			Get-AFCMSINFO.ps1 working from Get-7zip_PSW.ps1 

		.DESCRIPTION
			Takes an input archive full path througth Get-ChildItem Full_Path\*.extention
			
			#Could include a progress bar
			#Could be a Cmdlet
			Based on 7-Zip 9.20 64-bits
			
		.PARAMETER  ParameterA
			The description of the ParameterA parameter.

		.PARAMETER  ParameterB
			The description of the ParameterB parameter.

		.EXAMPLE
			PS C:\Users\tcailleau\Documents> gci 'C:\Users\tcailleau\Documents\EMEA_files\Temp\006xxxxx\0062xxxx\00625330\Customer\DFC-W2K8EVAULTP3.Customer.local-2015-01-30--15-55-33-825.zip' | Invoke-SevenZipPswd
			begin: This function expects a archive file like .tar .bz2 .bz .zip as a pipeline input Get-ChildItem Your_Path\*.bz2 ...

			7-Zip [64] 9.20  Copyright (c) 1999-2010 Igor Pavlov  2010-11-18

			Processing archive: C:\Users\tcailleau\Documents\EMEA_files\Temp\006xxxxx\0062xxxx\00625330\Customer\DFC-W2K8EVAULTP3.Customer.local-2015-01-30--15-55-33-825.zip

			Extracting  app.csv
			[...]
			Extracting  vaultdb.bak

			Everything is Ok

			Folders: 6
			Files: 2113
			Size:       918073268
			Compressed: 201134797
			Output is: C:\Users\tcailleau\Documents\EMEA_files\Temp\006xxxxx\0062xxxx\00625330\Customer\DFC-W2K8EVAULTP3.Customer.local-2015-01-30--15-55-33-825.zip  uncompressed or untared or 
			unarchived
			end: All is uncompressed or unarchive. This function return the created unarchive path:
			DFC-W2K8EVAULTP3


		.EXAMPLE
			
			


		.INPUTS
			This function expects a archive file like .tar .bz2 .bz .zip as a pipeline input Get-ChildItem Your_Path\*.bz2 ...

		.OUTPUTS
			Returns the last processed sub-direcotry "$_.Name.Replace('.zip','')" to the Pipe i.e. to $_

		.NOTES
			Additional information about the function go here.

		.LINK
			about_functions_advanced

		.LINK
			about_comment_based_help

	#>
	begin {
	Write-OutPut "begin: This function expects a archive file like .tar .bz2 .bz .zip as a pipeline input Get-ChildItem Your_Path\*.bz2 ..."
	Write-OutPut "Reading Passowrd from Credentail Manager i.e. set separately"
	#Getting's AFC password from CredMan via modules: SecretManagement.JustinGrote.CredMan and Microsoft.PowerShell.SecretStore and Microsoft.PowerShell.SecretManagement
	# in an attempt to store the password permamently on my PC in Windows Credential Manager + the perk of being able to port that script to other OS in the future...
	# See Set-MyCredentials.ps1 from 07_29_2021 to find out where and how the AFC password is stored on my PC
	$pswd = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR((Get-Secret -Name AFC).Password))
	}
	process {
	# runs once per pipeline object pipeline object
	# here $_ represnets the archive file to uncompress, untar
	if (-not (test-path $Env:ProgramFiles\7-Zip\7z.exe)) {throw "$Env:ProgramFiles\7-Zip\7z.exe needed"}
	# this is a powershell invokation of the 7z.exe
	# Harder to read but "$_.FullName.Split('\\')[-1].Replace('.zip','')" get the full name with extention, then replaces '.zip' by nothing. This allows for zip file without extra "." in then to still be able to create a extraction directory name
	Write-Host "Processing extraction... ...please wait this could take a while"
	&"$Env:ProgramFiles\7-Zip\7z.exe" e $_ -aou ("-p$pswd") ("-o" + $_.DirectoryName + '\' + $_.FullName.Split('\\')[-1].Replace('.zip','')) *.nfo
	#The Remove-Variable cmdlet takes the name of the variable as a paramater, not the $variable itself 
	Remove-Variable pswd
	Write-Host "Extraction complete"
	Write-OutPut "Output is: $_  uncompressed or untared or unarchived"
	}
	end {
	Write-OutPut "end: All is uncompressed or unarchive. This function return the created unarchive path:"
	return $_.FullName.Split('\\')[-1].Replace('.zip','')
	}
}

Clear-Host
