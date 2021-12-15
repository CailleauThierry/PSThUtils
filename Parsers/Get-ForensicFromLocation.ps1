<#
	.SYNOPSIS
		Get-ForensicFromLocation.ps1 requests the Forensic location and passes it to Get-Forensic.ps1

	.DESCRIPTION
        Get-ForensicFromLocation requests the Forensic location and passes it to Get-Forensic.ps1
        This script is meant to be called as part of the AHK keyboard shortcut

	.PARAMETER  ParameterA
		

	.EXAMPLE
		

	.EXAMPLE
		
	.EXAMPLE

	.INPUTS
		System.String

	.OUTPUTS
		File(s) path(es)$inout

	.NOTES
		Additional information about the function go here.

	.LINK
		about_functions_advanced

	.LINK
		about_comment_based_help

#>
. ..\FileHandling\Get-FileName.ps1


$inputfile = Get-FileName "C:\Temp" 

$inputfile | .\Get-Forensic.ps1 