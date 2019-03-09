####################################################################################################
#          Remove-UnZip.ps1 : Version 0.0.0.1
# Author: Thierry Cailleau
# Date: 03/09/2019
#
#
# Detects .zip file name and removes any folders with the same name.
# The goal is to recover space taken from Get-AFC and Get-DFC
#
####################################################################################################

<#  --------------  Changes History  -----------------
Version 0.0.0.1:
- removes every unzipped folders for .tar.bz2 files
- Tested on PS 5.1 and PS Core 6.1
--------------  end of Changes History  -----------------
#>

<#
	.SYNOPSIS
		Detects .zip file name and removes any folders with the same name.
		The goal is to recover space taken from Get-AFC and Get-DFC

	.DESCRIPTION
		Detects .zip file name and removes any folders with the same name.
		The goal is to recover space taken from Get-AFC and Get-DFC

	.PARAMETER
		no parameter

	.EXAMPLE
		Launch the script by navigating to Remove-UnZip.ps1 location and launch it .\Remove-UnZip.ps1 It will remove every unzipped folders for .tar.bz2 files

	.INPUTS
		no input

	.OUTPUTS
		removes

	.NOTES
		Script must be executed from C:\ in a PowerShell session ran as Administrator

	.LINK
		N/A

#>
# This script requires PowerShell version 2 or above to run
#Requires -Version 2.0

Get-ChildItem -Path C:\Temp\04xxxxxx\ -Include *.bz2 -Recurse | ForEach-Object {
	if (($_.Name.Split(".")[-2].ToString() + "." + $_.Name.Split(".")[-1].ToString()) -eq "tar.bz2") {
		if (Test-Path ($_.FullName.Split(".")[0])){
		Remove-Item -Path $_.FullName.Split(".")[0] -Recurse
		}
		else {
			Write-Output "$_.Name did not have an expanded Directory to Delete"
		}
	}
}