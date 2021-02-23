<#
	.NOTES
	===========================================================================
	 Posted by : 	My own investigation from PowerShell prompt
	 Created on:   02_21_2021 9:33 PM
	 Created by:   CailleauThierry
	 Organization: Private
	 Filename:     Set-U1604DIP.ps1
	===========================================================================
	.DESCRIPTION
After instaling the LIS (Linux Integration Services) packages on Ubuntu 16.04.7 LTS the IP finally shows in Hyper-V > Networking Tab... 
... this allows us to accss the IP in PowerShell... ..Running "As Administrator" (also run vscode "As Administrator")

sudo apt-get install linux-virtual-lts-xenial linux-tools-virtual-lts-xenial linux-cloud-tools-virtual-lts-xenial

   61  sudo apt-get linux-tools-4.15.0-133-generic
   62  sudo apt-get install linux-tools-4.15.0-133-generic
   63  sudo apt-get install linux-cloud-tools-4.15.0-133-generic
   64  sudo apt-get install linux-tools-generic
   65  sudo apt-get install linux-cloud-tools-generic
   66  hv_fcopy_daemon
   67  hv_kvp_daemon
   68  hv_set_ifconfig
   69  hv_vss_daemon
   70  hv_get_dns_info
   71  sudo shudown -h now

   This script reads the current IP address (changes constantly), and edit the Remote Desktop file with that information U1604D.rdp
#>

# $U1604D_IP = get-vm | Where-Object Name -Match 'U1604D' | Select-Object NetworkAdapters -ExpandProperty NetworkAdapters | Select-Object IPAddresses -ExpandProperty IPAddresses | Select-Object -First 1
$U1604D_IP = (get-vm -Name U1604D).NetworkAdapters.IPAddresses[0]

$U1604D_IP

# and with help from https://stackoverflow.com/questions/48813786/change-the-contents-of-a-rdp-file-with-powershell

$RDP = Get-ChildItem "C:\Users\tcailleau\Desktop\U1604D.rdp"

(get-content $RDP) -replace 'full address:s:.*', "full address:s:$U1604D_IP" | set-content $RDP
