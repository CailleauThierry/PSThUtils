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
<# 

PS C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils> c:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils\FileHandling\Get-FileName.ps1


    Directory: C:\Temp


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----         5/19/2021   9:48 PM         151854 list_of_apps.txt


PS C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils\FileHandling>
 #>
Function Get-FileName($initialDirectory) {
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
	$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFileDialog.initialDirectory = $initialDirectory
    $OpenFileDialog.Multiselect = $true
    $OpenFileDialog.filter = "ALL (*.*)| *.*"
    $OpenFileDialog.ShowDialog() | Out-Null
    $OpenFileDialog.filenames
    }
#Get-FileName "C:\Temp"
