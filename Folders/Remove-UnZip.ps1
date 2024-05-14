####################################################################################################
#          Remove-UnZip.ps1 : Version 0.0.0.2
# Author: Thierry Cailleau
# Date: 02/12/2022
#
#
# Detects .zip file name and removes any folders with the same name.
# The goal is to recover space taken from Get-AFC, Get-DFC and GET-PFC
# It should still removes every unzipped folders for .tar.bz2 files (not tested on 02_12_2022 for Version 0.0.0.2 release)
#
####################################################################################################

<#  --------------  Changes History  -----------------
Version 0.0.0.2:
- Removed unused variable: $PowerShellSource
- Changed the mechanism to detect .zip file name i.e. also the default folder name .zip would extract as using the $_.Basename
This is a major improvement in what the script is able to detect. I recovered 200 GB on 02_11_2022
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
[Parameter(Mandatory=$false,  HelpMessage="Please specify the Directory To Scan")]
[string] $DirToScan = "C:\Temp\06xxxxxx"
)

$LogFolder = (Split-Path $profile) + '\' + 'UnZip_Logs'

if (-not (Test-Path $LogFolder)) {
new-item -itemtype directory $LogFolder
}

$null = Get-Location
Get-ChildItem -Path $DirToScan -Include *.bz2,*.zip -Recurse | ForEach-Object {
	if (($_.Name.Split(".")[-2].ToString() + "." + $_.Name.Split(".")[-1].ToString()) -eq "tar.bz2") {
		if (Test-Path ($_.FullName.Split(".")[0])){
		Remove-Item -Path $_.FullName.Split(".")[0] -Recurse -Force
		}
		else {
			Write-Output "$_.Name did not have an expanded Directory to Delete"
		}
	}
	elseif (($_.Name.Split(".")[-2].ToString() + "." + $_.Name.Split(".")[-1].ToString()) -eq "tar.gz") {
		if (Test-Path ($_.FullName.Split(".")[0])){
		Remove-Item -Path $_.FullName.Split(".")[0] -Recurse -Force
		}
		else {
			Write-Output "$_.Name did not have an expanded Directory to Delete"
		}
	}
	elseif ($_.Name -match "AFC.*\.zip") {
		$AFCShortDir = $_.Basename
		$UnzipDirectory = $_.DirectoryName + "\" + "$AFCShortDir"
		if (Test-Path $UnzipDirectory){
		Remove-Item -Path $UnzipDirectory -Recurse -Force
		}
		else {
			Write-Output "$($_.Name) did not have an expanded Directory $UnzipDirectory to Delete"
			Out-File $LogFolder\Remove-UnZip.log -Append
		}
	}
	elseif ($_.Name -match "DFC.*\.zip") {
		# .Basename give you the file name without its extention
		$DFCShortDir = $_.Basename
		$UnzipDirectory = $_.DirectoryName + "\" + "$DFCShortDir"
		if (Test-Path $UnzipDirectory){
		Remove-Item -Path $UnzipDirectory -Recurse -Force
		}
		else {
			Write-Output "$($_.Name) did not have an expanded Directory $UnzipDirectory to Delete"
			Out-File $LogFolder\Remove-UnZip.log -Append
		}
	}
	elseif ($_.Name -match "PFC.*\.zip") {
		$PFCShortDir = $_.Basename
		$UnzipDirectory = $_.DirectoryName + "\" + "$PFCShortDir"
		if (Test-Path $UnzipDirectory){
		Remove-Item -Path $UnzipDirectory -Recurse -Force
		}
		else {
			Write-Output "$($_.Name) did not have an expanded Directory $UnzipDirectory to Delete"
			Out-File $LogFolder\Remove-UnZip.log -Append
		}
	}
	elseif ($_.Name.Split(".")[-1].ToString() -eq "zip") {
		$ShortDir = $_.Basename
		$UnzipDirectory = $_.DirectoryName + "\" + "$ShortDir"
		if (Test-Path $UnzipDirectory){
		Remove-Item -Path $UnzipDirectory -Recurse -Force
		}
		else {
			Write-Output "$($_.Name) did not have an expanded Directory $UnzipDirectory to Delete"
			Out-File $LogFolder\Remove-UnZip.log -Append
		}
	}


}