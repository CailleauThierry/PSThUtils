<#
Remove-VirtualMachines.ps1 # https://mvp.microsoft.com/en-us/PublicProfile/5002955?fullName=Yinghua%20Zeng

[1:01 PM] CJ Hathenbruck
    Long story short for my sleepy brain, it goes through, finds the files that are tied the the GUID for the machine, then deletes them.
There is also a test feature.

I use this on our hyper-v lab.
​[1:02 PM] CJ Hathenbruck
    Goes through and gets all the hard to find files.

	[1:06 PM] CJ Hathenbruck
    Doing a test delete will also tell you where the files are located.
[mRemoteNG_2020-04-04_05-06-29.png] (https://carbonite-my.sharepoint.com/personal/chathenbruck_carbonite_com1/Documents/Microsoft Teams Chat Files/mRemoteNG_2020-04-04_05-06-29.png)

PS C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils\HyperV> .\Remove-VirtualMachines.ps1
Delete Hyper-V Virtual Machines
-------------------------------
################################################
1 List all Virtual Machines names on this host
2 Test delete Virtual Machines
3 Delete Virtual Machines
Q Quit

################################################


Select a task by number or Q to quit: 1
Getting Virtual Machines informations
cert16
COS81
u1910
W12R2V3
W16
Delete Hyper-V Virtual Machines
-------------------------------
################################################
1 List all Virtual Machines names on this host
2 Test delete Virtual Machines
3 Delete Virtual Machines
Q Quit

################################################


Select a task by number or Q to quit:



.This is a menu base script for delete Hyper-V virtual Machines, and also delete snapshots, and harddisks what are using in those Virtual Machines that you want to delete.
 .This can be run localy in Hyper-V host, not remotely.
 .This has tested in Windows 10 Hyper-V host.
 .This has not tested in cluster envirements.
 .This is a quick publish script. You are welcome to modify as you wish.

 Version      : 1.0
 Last Modified: January 17, 2017
 Author       : Zeng Yinghua


  ****************************************************************
  * DO NOT USE IN A PRODUCTION ENVIRONMENT UNTIL YOU HAVE TESTED *
  * THOROUGHLY IN A LAB ENVIRONMENT. USE AT YOUR OWN RISK.  IF   *
  * YOU DO NOT UNDERSTAND WHAT THIS SCRIPT DOES OR HOW IT WORKS, *
  * DO NOT USE IT OUTSIDE OF A SECURE, TEST SETTING.             *
  ****************************************************************

Choose 1 for list all Virtual Machines in the host
Choose 2 for test delete Virtual Machines, put your Virtual Machines name when it ask for VMName
Choose 3 for delete Virtual Machines, put your Virtual Machines name when it ask for VMName
Choose Q to exit script

 #>

Function Remove-MyLabVM
{
<#
 .This is a funtion for delete Hyper-V virtual Machines, and also delete snapshots, and harddisks what are using in those Virtual Machines that you want to delete.
 .This can be run localy in Hyper-V host, not remotely.
 .This has tested in Windows 10 Hyper-V host.
 .This has not tested in cluster envirements.
 .This is a quick publish script. You are welcome to modify as you wish.

 Version      : 1.0
 Last Modified: January 17, 2017
 Author       : Zeng Yinghua


  ****************************************************************
  * DO NOT USE IN A PRODUCTION ENVIRONMENT UNTIL YOU HAVE TESTED *
  * THOROUGHLY IN A LAB ENVIRONMENT. USE AT YOUR OWN RISK.  IF   *
  * YOU DO NOT UNDERSTAND WHAT THIS SCRIPT DOES OR HOW IT WORKS, *
  * DO NOT USE IT OUTSIDE OF A SECURE, TEST SETTING.             *
  ****************************************************************

 .Example
 .Run this command without -Whatif to remove Virtual Machines name "TestVM01" and "TestVM02"
 PS C:\> Remove-MyLabVM 'TestVM01', "TestVM02"

 .Example
 .Run this command with Whatif to remove What If to test remove Virtual Machines name "TestVM01" and "TestVM02" command
 PS C:\> Remove-MyLabVM 'TestVM01', "TestVM01" -WhatIf


 #>
	[cmdletbinding(SupportsShouldProcess = $True)]
	param (
		[Parameter(
				   Mandatory = $true,
				   HelpMessage = "Name of Virtual Machines")]
		[String[]]$VMNames

	)


	foreach ($VMName in $VMNames)
	{

		$VM = GET-VM -VM $Vmname -Verbose -ErrorAction SilentlyContinue

		if ($VM)
		{
			Write-Host "Stopping Virtual Machine $VM" -ForegroundColor Green
			Stop-VM -VM $VM -Force

			Get-VMSnapshot -VMName $VMName | select -ExpandProperty HardDrives | ForEach-Object { Get-VHD $_.Path | select Path } | Remove-item -Force -Verbose
			GET-VMHardDiskDrive -VMName $VMName | Select-Object Path | Remove-item -Force -Verbose


			Write-Host "Removing Virtual Machine $VM" -ForegroundColor Green
			Remove-VM $VM -Force -Verbose
		}


	}
}

$menu =@"
################################################
1 List all Virtual Machines names on this host
2 Test delete Virtual Machines
3 Delete Virtual Machines
Q Quit

################################################


Select a task by number or Q to quit
"@

Function Invoke-Menu
{
	[cmdletbinding()]
	Param (
		[Parameter(Position = 0, Mandatory = $True, HelpMessage = "Enter your menu text")]
		[ValidateNotNullOrEmpty()]
		[string]$Menu,
		[Parameter(Position = 1)]
		[ValidateNotNullOrEmpty()]
		[string]$Title = "My Menu",
		[Alias("cls")]
		[switch]$ClearScreen
	)

	#clear the screen if requested
	if ($ClearScreen)
	{
		Clear-Host
	}

	#build the menu prompt
	$menuPrompt = $title
	#add a return
	$menuprompt += "`n"
	#add an underline
	$menuprompt += "-" * $title.Length
	#add another return
	$menuprompt += "`n"
	#add the menu
	$menuPrompt += $menu

	Read-Host -Prompt $menuprompt

} #end function

Do
{
	#use a Switch construct to take action depending on what menu choice
	#is selected.
	Switch (Invoke-Menu -menu $menu -title "Delete Hyper-V Virtual Machines")
	{
		"1" {
			Write-Host "Getting Virtual Machines informations" -ForegroundColor Yellow
			$getvm = Get-VM | select name
			$getvm.name
			sleep -seconds 2
		}
		"2" {
			Write-Host "Testing delete Virtual Machines" -ForegroundColor Green
			sleep -seconds 2
			Remove-MyLabVM -WhatIf
		}
		"3" {
			Write-Host "Deleting Virtual Machines" -ForegroundColor Magenta
			Remove-MyLabVM
			sleep -seconds 2
		}
		"Q" {
			Write-Host "Goodbye" -ForegroundColor Cyan
			Return
		}
		Default
		{
			Write-Warning "Invalid Choice. Try again."
			sleep -milliseconds 750
		}
	} #switch
}
While ($True)