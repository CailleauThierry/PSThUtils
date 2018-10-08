#requires -Version 2.0 -Modules Microsoft.PowerShell.Management
<#
	.SYNOPSIS
		Get-EBCDICToASCII.ps1 on 09/05/2018 version 0.1 is based on this post https://www.powershellmagazine.com/2013/06/17/working-with-non-native-powershell-encoding-ebcdic/
	
	.DESCRIPTION
		Takes a text file asuming you know it is encodeing in IBM EBCDIC format and create a same file name in same location with _to_ASCII.txt extension in Windows readable ASCII format
	.EXAMPLE. 
		Drag&Drop of the EBCDIC log file to the script shotcut. It takes the full path from it and create a same name same location with added extention _to_ASCII.txt

	.INPUTS
		Any IBM EBCDIC formatted log file

	.OUTPUTS
		TypeName: System.String > to the file system 

	.NOTES
		This is version 0.1 working

	.LINK
		about_comment_based_help

#>


param ( 
[Parameter(mandatory=$true,HelpMessage='Needs full path to file to parse')][string] $SourceFileName
)

$ConvertedFile = "$SourceFileName" + "_to_ASCII.txt"
$Buffer = Get-Content $SourceFileName -Encoding byte
$Encoding = [System.Text.Encoding]::GetEncoding("IBM01149")
#[string]$EBCDICEncoding = @(IBM1026, IBM01047, IBM01140, IBM01141, IBM01142, IBM01143, IBM01144, IBM01145, IBM01146, IBM01147, IBM01148, IBM01149)
$Encoding.GetString($Buffer) | Out-File $ConvertedFile  -Force