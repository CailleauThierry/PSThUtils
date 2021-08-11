<# 
Set-MyCredentials.ps1 on 07_29_2021 by Thierry Cailleau
REQUIREMENTS
   Install-Module -Name Microsoft.PowerShell.SecretManagement -RequiredVersion 1.0.0
   Install-Module -Name Microsoft.PowerShell.SecretStore
   Install-Module -Name SecretManagement.JustinGrote.CredMan
#>

<# 
PS C:\WINDOWS\system32> Install-Module -Name Microsoft.PowerShell.SecretManagement -RequiredVersion 1.0.0

Untrusted repository
You are installing the modules from an untrusted repository. If you trust this repository, change its InstallationPolicy value by running the Set-PSRepository cmdlet. Are you sure you want
to install the modules from 'PSGallery'?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"): A
PS C:\WINDOWS\system32> Install-Module -Name Microsoft.PowerShell.SecretStore

Untrusted repository
You are installing the modules from an untrusted repository. If you trust this repository, change its InstallationPolicy value by running the Set-PSRepository cmdlet. Are you sure you want
to install the modules from 'PSGallery'?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"): A
PS C:\WINDOWS\system32> Install-Module -Name SecretManagement.JustinGrote.CredMan

Untrusted repository
You are installing the modules from an untrusted repository. If you trust this repository, change its InstallationPolicy value by running the Set-PSRepository cmdlet. Are you sure you want
to install the modules from 'PSGallery'?
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"): A
PS C:\WINDOWS\system32> Register-SecretVault SecretManagement.JustinGrote.CredMan
PS C:\WINDOWS\system32> Set-SecretVaultDefault -Name "SecretManagement.JustinGrote.CredMan"
PS C:\WINDOWS\system32> Get-SecretVault

Name                                 ModuleName                           IsDefaultVault
----                                 ----------                           --------------
SecretManagement.JustinGrote.CredMan SecretManagement.JustinGrote.CredMan True
PS C:\WINDOWS\system32> Set-Secret -Secret (Get-Credential) -Name AFC

cmdlet Get-Credential at command pipeline position 1
Supply values for the following parameters:
Credential
PS C:\WINDOWS\system32> Get-Secret -Name AFC -AsPlainText

UserName                                   Password
--------                                   --------
carboniteinc\tcailleau System.Security.SecureString

#>

Set-Secret -Secret (Get-Credential) -Name AFC


