<#	
	.NOTES
	===========================================================================
	 From: https://social.technet.microsoft.com/Forums/windowsserver/en-US/11218cf2-eb24-4110-967f-b29234064501/how-do-i-save-outlook-attachments-using-powershell?forum=winserverpowershell
	 Created on:   	7/6/2016 1:18 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>
# <-- Script --------->
#requires -Version 2
$o = New-Object -comobject outlook.application
$n = $o.GetNamespace("MAPI")
$f = $n.PickFolder()
$filepath = "c:\temp\"
$f.Items | foreach {
	$SendName = $_.SenderName
	$_.attachments | foreach {
		Write-Host $_.filename
		$a = $_.filename
		If ($a.Contains("xlsx"))
		{
			$_.saveasfile((Join-Path $filepath "$SendName.xlsx"))
		}
	}
}
# <------ End Script ---------------------------------->
#me: this works great with PS v5 and v2. It only requires you frist create a C:\temp\ folder (this could be added to the script)
#It then asks you to select the folder you want ot scan (I selected the Inbox) folder.
#The script "Write-Host" actually display all attachments (.png .jpg) so the "If ($a.Contains("xlsx"))" part of it line 24 could be chnage to the different extensions you need,
#	you could even replace with If ($a -match "xlsx") for regex matching of different extension types
