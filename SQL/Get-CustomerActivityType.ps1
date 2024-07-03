<#
PS E:\Director\Scripts> dir


    Directory: E:\Director\Scripts


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        4/21/2023  11:06 AM          19531 addRemoveVaultShutdownScript.ps1
-a----         7/2/2024   1:09 PM            735 Get-CustomerActivityType.ps1
-a----        5/21/2024  11:38 PM           8638 Get-LoaderFindVault.ps1
-a----        4/21/2023  11:06 AM           3638 ShutdownVault.ps1
-a----        4/21/2023  11:06 AM           3535 VaultSettings.ps1


PS C:\Users\Administrator> . 'E:\Director\Scripts\Get-CustomerActivityType.ps1'
For Primary:

activitytype
------------
           1
           4
          12
For THC01Name:
           1
           4
          12


PS C:\Users\Administrator> cat C:\Temp\Results_TCD1_7_2_2024.log
For Primary:

activitytype
------------
           1
           4
          12
For THC01Name:
           1
           4
          12


PS C:\Users\Administrator>
#>

$MyDate = (Get-Date).ToShortDateString().Replace('/', '_')
$VaultHostname = (Invoke-SqlCmd -ServerInstance localhost\evault_db -Database vault "Select HostName FROM vault").HostName

$CustomerNames = (Invoke-SqlCmd -ServerInstance localhost\evault_db -Database vault "Select customername FROM customer").customername
$CustomerNames | ForEach-Object{
$customerName = $_
$query = @"
select distinct activitytype from activityentries where taskID in (
SELECT taskID FROM [Vault].[dbo].[task] where customerComputerID in
(SELECT CustomerComputerID FROM [Vault].[dbo].[customercomputer] where CustomerLocationID IN
(select CustomerLocationID from [Vault].[dbo].[customerlocation] where CustomerID IN
(select customerID from [Vault].[dbo].[customer] where customername like '$customerName'))))
"@
Write-Output "For ${customerName}:"
Invoke-SqlCmd -ServerInstance localhost\evault_db -Database vault -Query $query
} | Tee-Object C:\Temp\Results_${VaultHostname}_${MyDate}.log