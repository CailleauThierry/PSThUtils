<# PS C:\Users\Administrator> Install-Module -Name PSWindowsUpdate -Force
 
NuGet provider is required to continue
PowerShellGet requires NuGet provider version '2.8.5.201' or newer to interact with NuGet-based repositories. The NuGet
provider must be available in 'C:\Program Files\PackageManagement\ProviderAssemblies' or
'C:\Users\Administrator\AppData\Local\PackageManagement\ProviderAssemblies'. You can also install the NuGet provider by
running 'Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force'. Do you want PowerShellGet to install
and import the NuGet provider now?
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"): Y
PS C:\Users\Administrator> Get-ExecutionPolicy
RemoteSigned
PS C:\Users\Administrator> Import-Module PSWindowsUpdate
PS C:\Users\Administrator> Get-Command -module PSWindowsUpdate
 
CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Alias           Clear-WUJob                                        2.2.1.5    PSWindowsUpdate
Alias           Download-WindowsUpdate                             2.2.1.5    PSWindowsUpdate
Alias           Get-WUInstall                                      2.2.1.5    PSWindowsUpdate
Alias           Get-WUList                                         2.2.1.5    PSWindowsUpdate
Alias           Hide-WindowsUpdate                                 2.2.1.5    PSWindowsUpdate
Alias           Install-WindowsUpdate                              2.2.1.5    PSWindowsUpdate
Alias           Show-WindowsUpdate                                 2.2.1.5    PSWindowsUpdate
Alias           UnHide-WindowsUpdate                               2.2.1.5    PSWindowsUpdate
Alias           Uninstall-WindowsUpdate                            2.2.1.5    PSWindowsUpdate
Cmdlet          Add-WUServiceManager                               2.2.1.5    PSWindowsUpdate
Cmdlet          Enable-WURemoting                                  2.2.1.5    PSWindowsUpdate
Cmdlet          Get-WindowsUpdate                                  2.2.1.5    PSWindowsUpdate
Cmdlet          Get-WUApiVersion                                   2.2.1.5    PSWindowsUpdate
Cmdlet          Get-WUHistory                                      2.2.1.5    PSWindowsUpdate
Cmdlet          Get-WUInstallerStatus                              2.2.1.5    PSWindowsUpdate
Cmdlet          Get-WUJob                                          2.2.1.5    PSWindowsUpdate
Cmdlet          Get-WULastResults                                  2.2.1.5    PSWindowsUpdate
Cmdlet          Get-WUOfflineMSU                                   2.2.1.5    PSWindowsUpdate
Cmdlet          Get-WURebootStatus                                 2.2.1.5    PSWindowsUpdate
Cmdlet          Get-WUServiceManager                               2.2.1.5    PSWindowsUpdate
Cmdlet          Get-WUSettings                                     2.2.1.5    PSWindowsUpdate
Cmdlet          Invoke-WUJob                                       2.2.1.5    PSWindowsUpdate
Cmdlet          Remove-WindowsUpdate                               2.2.1.5    PSWindowsUpdate
Cmdlet          Remove-WUServiceManager                            2.2.1.5    PSWindowsUpdate
Cmdlet          Reset-WUComponents                                 2.2.1.5    PSWindowsUpdate
Cmdlet          Set-PSWUSettings                                   2.2.1.5    PSWindowsUpdate
Cmdlet          Set-WUSettings                                     2.2.1.5    PSWindowsUpdate
Cmdlet          Update-WUModule                                    2.2.1.5    PSWindowsUpdate
 
 
PS C:\Users\Administrator> Get-WUList
 
ComputerName Status     KB          Size Title
------------ ------     --          ---- -----
WIN-2KK6F... -------    KB5041017   88MB 2024-07 Cumulative Update for .NET Framework 3.5, 4.7.2 and 4.8 for Windows...
WIN-2KK6F... -------    KB5040948  880MB Security Update for SQL Server 2019 RTM CU (KB5040948)
WIN-2KK6F... -D-----    KB5039747  880MB SQL Server 2019 RTM Cumulative Update (CU) 28 KB5039747
WIN-2KK6F... -D-----    KB5042350   89MB 2024-08 Cumulative Update for .NET Framework 3.5, 4.7.2 and 4.8 for Windows...
WIN-2KK6F... -D-----    KB5041578  656MB 2024-08 Cumulative Update for Windows Server 2019 for x64-based Systems (KB...
WIN-2KK6F... -D-----    KB890830    71MB Windows Malicious Software Removal Tool x64 - v5.127 (KB890830)
WIN-2KK6F... -------    KB2267602    1GB Security Intelligence Update for Microsoft Defender Antivirus - KB2267602 (...
 
 
PS C:\Users\Administrator> Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot
 
X ComputerName Result     KB          Size Title
- ------------ ------     --          ---- -----
1 WIN-2KK6F... Accepted   KB5040711    6MB Security Update for Microsoft OLE DB Driver for SQL Server (KB5040711)
1 WIN-2KK6F... Accepted   KB5040948  880MB Security Update for SQL Server 2019 RTM CU (KB5040948)
1 WIN-2KK6F... Accepted   KB5039747  880MB SQL Server 2019 RTM Cumulative Update (CU) 28 KB5039747
1 WIN-2KK6F... Accepted   KB890830    71MB Windows Malicious Software Removal Tool x64 - v5.127 (KB890830)
1 WIN-2KK6F... Accepted   KB5042350   89MB 2024-08 Cumulative Update for .NET Framework 3.5, 4.7.2 and 4.8 for Windo...
1 WIN-2KK6F... Accepted   KB2267602    1GB Security Intelligence Update for Microsoft Defender Antivirus - KB2267602...
1 WIN-2KK6F... Accepted   KB5041578   17GB 2024-08 Cumulative Update for Windows Server 2019 (1809) for x64-based Sy...
2 WIN-2KK6F... Downloaded KB5040711    6MB Security Update for Microsoft OLE DB Driver for SQL Server (KB5040711)
2 WIN-2KK6F... Downloaded KB5040948  880MB Security Update for SQL Server 2019 RTM CU (KB5040948)
2 WIN-2KK6F... Downloaded KB5039747  880MB SQL Server 2019 RTM Cumulative Update (CU) 28 KB5039747
2 WIN-2KK6F... Downloaded KB890830    71MB Windows Malicious Software Removal Tool x64 - v5.127 (KB890830)
2 WIN-2KK6F... Downloaded KB5042350   89MB 2024-08 Cumulative Update for .NET Framework 3.5, 4.7.2 and 4.8 for Windo...
2 WIN-2KK6F... Downloaded KB2267602    1GB Security Intelligence Update for Microsoft Defender Antivirus - KB2267602...
2 WIN-2KK6F... Downloaded KB5041578   17GB 2024-08 Cumulative Update for Windows Server 2019 (1809) for x64-based Sy...
3 WIN-2KK6F... Installed  KB5040711    6MB Security Update for Microsoft OLE DB Driver for SQL Server (KB5040711)
3 WIN-2KK6F... Installed  KB5040948  880MB Security Update for SQL Server 2019 RTM CU (KB5040948)
3 WIN-2KK6F... Installed  KB5039747  880MB SQL Server 2019 RTM Cumulative Update (CU) 28 KB5039747
3 WIN-2KK6F... Installed  KB890830    71MB Windows Malicious Software Removal Tool x64 - v5.127 (KB890830)
3 WIN-2KK6F... Installed  KB5042350   89MB 2024-08 Cumulative Update for .NET Framework 3.5, 4.7.2 and 4.8 for Windo...
3 WIN-2KK6F... Installed  KB2267602    1GB Security Intelligence Update for Microsoft Defender Antivirus - KB2267602...
 
Tuesday 4:33 PM Meeting ended: 31m 29s  #>

Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot