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

# Parameter help description
param(
[Parameter(Mandatory=$true,  HelpMessage="Please specify the Directory To Scan")]
[string] $DirToScan = "C:\Temp\04xxxxxx\"
)

$LogFolder = (Split-Path $profile) + '\' + 'UnZip_Logs'

if (-not (Test-Path $LogFolder)) {
new-item -itemtype directory $LogFolder
}

$PowerShellSource = Get-Location
Get-ChildItem -Path $DirToScan -Include *.bz2,*.zip -Recurse | ForEach-Object {
	if (($_.Name.Split(".")[-2].ToString() + "." + $_.Name.Split(".")[-1].ToString()) -eq "tar.bz2") {
		if (Test-Path ($_.FullName.Split(".")[0])){
		Remove-Item -Path $_.FullName.Split(".")[0] -Recurse -Force
		}
		else {
			Write-Output "$_.Name did not have an expanded Directory to Delete"
		}
	}
	elseif ($_.Name -match "AFC.*\.zip") {
		$AFCShortDir = $_.Name.Split(".")[0]
		$UnzipDirectory = $_.DirectoryName + "\" + "$AFCShortDir"
		if (Test-Path $UnzipDirectory){
		Remove-Item -Path $UnzipDirectory -Recurse -Force
		}
		else {
			Write-Output "$($_.Name) did not have an expanded Directory $UnzipDirectory to Delete"
			Out-File $LogFolder\Remove-UnZip.log -Append
		}
	}
	elseif ($_.Name.Split(".")[-1].ToString() -eq "zip") {
		$UnzipDirectory = $_.FullName.Split(".")[0]
		if (Test-Path $UnzipDirectory){
		Remove-Item -Path $UnzipDirectory -Recurse -Force
		}
		else {
			Write-Output "$($_.Name) did not have an expanded Directory $UnzipDirectory to Delete"
			Out-File $LogFolder\Remove-UnZip.log -Append
		}
	}


}