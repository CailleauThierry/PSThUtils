<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2016 v5.2.123
	 Created on:   	7/27/2016 10:14 AM
	 Created by:   	Administrator
	 Organization: 	
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
#Get-ChildItem *.html | Rename-Item -NewName { $_.Name -replace '\.html', '.txt' }
#
#
#dir | %{ $x = 0 } { Rename-Item $_ -NewName "TestName$x.html"; $x++ }
#
#
#PS C:\Program Files\EVault Software\Portal Services\AMP Proxy Service> Get-ChildItem | Select {
#	$_.Extension
#	
#	$_.Extension
#	------------
#	
#	
#	.exe
#	.config
#	.dll
#	.txt
#	.dll
#	.dll
#	.dll
#	.xml

Read-Host [string]$extension
Read-Host [string]$sourcepath
Read-Host
Copy-Item -Filter *.$extension -Destination