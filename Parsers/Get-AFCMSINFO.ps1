<#
	.SYNOPSIS
		Get-AFCMSINFO.ps1 based on Get-AFC defines the function Invoke-SevenZipPswdCMAFCMsInfo

	.DESCRIPTION
		Get-AFCMSINFO.ps1
		Now works from $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\ for future ease of sharing it.
		- Extracts AFC-.*.zip (must be in this format for now).
		- Invoke-SevenZipPswdCMAFCMsInfo uses the "e" parameter of 7zip to extract a specific file type, here *.nfo

	.PARAMETER  ParameterA
		Only takes 1 single AFC-.*.zip file with complete path. Where '*' can be any charaters before the '.zip' extension

	.EXAMPLE
		Shift Drag&Drop AFC-.*.zip file to "Get-AFC.ps1 - Shortcut" place on windows taskbar

	.EXAMPLE
		PS C:\> Launch "Get-AFC.ps1 - Shortcut" and type in the full "AFC-.*.zip" path like:
		C:\posh\AFC-.*.zip
	.EXAMPLE
		Get-AFC.ps1 is now callable from Pipeline, the script in itself is the function Name
		PS C:\> gci c:\Temp\06xxxxxx\06292650\DFC-06292650-S174881X7719005-2021-06-23-09-40-11-519.zip | .\Get-AFC.ps1

	.INPUTS
		System.String

	.OUTPUTS
		Directory and file writen on drive

	.NOTES
		Additional information about the function go here.

	.LINK
		about_functions_advanced

	.LINK
		about_comment_based_help

#>


param ( 
[Parameter(
	Mandatory=$true,
	ValueFromPipeline=$true
	)
] 
[string]$AFCZip
)
# Passing AFC password from SecretStore CredMan
. $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-7zip_PSWMSINFO.ps1


# Obtains AFC full file name from the full file path collected in $AFCZip
$sb_name = ($AFCZip).Split('\\')[-1]

if (($sb_name) -match "AFC-.*.zip")
{


#extract the compressed files and create a sub-directory 1 (non-configurable). The extract folder / directory is created by 7z called within Invoke-SevenZipPswd function defined in Get-7zip_PSWMSINFO.ps1
$subdir1 = (Get-ChildItem $AFCZip | Invoke-SevenZipPswdCMAFCMsInfo)[-1]
# Note: This still does not test if AFC file is a valid zip file
} 
else
{
Write-Host 'did not find AFC-*.zip'
Write-Host "We only got $sb_name"
break
}

