<#	
	.NOTES
	===========================================================================
	 Created with: 	VSCode 1.60.2
	 Created on:   	10_01_2021 3:25 PM
	 Created by:   	Administrator
	 Organization: 	Private
	 Filename:      Get-FileName.ps1    	
	===========================================================================
	.DESCRIPTION
		This was inspired by: https://forums.mydigitallife.net/threads/how-to-functions-to-obtain-file-selection-or-folder-selection-in-gui-in-powershell.74818/
#>


Function Get-FileName($initialDirectory) {
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.Multiselect = $true
    $OpenFileDialog.filter = "AVI (*.avi)| *.avi|MP4 (*.mp4)| *.mp4|MKV (*.mkv)| *.mkv|WMV (*.wmv)| *.wmv"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filenames
    }
$inputfile = Get-FileName "C:\"
$files = get-childitem $inputfile

 

$files