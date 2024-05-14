# Get-SQLTableContent.ps1 Created on 03_26_2024 by Thierry Cailleau

# Inspired from:
# Invoke-Sqlcmd -Query "SELECT * from <database_name>.<schema_name>.<table_name>;" -ServerInstance "<server_instance>" | Export-Csv -Path "file_ destination_path" -NoTypeInformation
#    Where:
# • <database_name>: a database name that contains a table you want to export data from. Value example to enter is AdventureWorks2019.
# • <schema_name>: a schema name of a table you want to export data from. Value example to enter is Sales.
# • <table_name>: a table name you want to export data from. Value example to enter is Store.
# • <server_instance>: a name of SQL Server instance to which to connect.
# • <file_destination_path>: a location where a specified .csv file will be stored. Value example to enter is D:\store.csv.
# 3. Check the exported .csv by the location that you have specified in <file_destination_path>.

# From <https://blog.devart.com/how-to-export-sql-server-data-from-table-to-a-csv-file.html> 

# Usage, run as follow from a PowerShell prompt as Sdministator:
# PS C:\Users\Administrator\Documents\WindowsPowerShell\Scripts\PSThUtils> . 'C:\Users\Administrator\Documents\WindowsPowerShell\Scripts\PSThUtils\SQL\Get-SQLTableCon
# tent.ps1'
# This script could take a while to complete as some tables might be very large...
# ...the script has now completed. Please review the table content in C:\Temp\$table.log

# You will have 1 log file for each tables of the Vault database in the following folder: C:\Temp\
# You can find an example zipped result from my test environment: C:\Users\Administrator\Documents\WindowsPowerShell\Scripts\PSThUtils\SQL\TCDTemp.zip

$database_name = 'Vault'
$schema_name1 = 'sys'
$schema_name2 = 'dbo'
$server_instance = 'TCDTemp\Evault_db'

# the last ).name translates an property called "name" into a list of name (strings only)

if (-not (Test-Path "C:\Temp\SQLTables\")) { # Test if C:\Temp\SQLTables\ path exist. If not it creates that path
    $Silent = new-item -itemtype directory "C:\Temp\SQLTables\"
    }

$tableNames = (Invoke-Sqlcmd -Query "SELECT * from [$database_name].[$schema_name1].tables" -ServerInstance "$server_instance" | Select-Object name).name
Write-Output "This script could take a while to complete as some tables might be very large..."
$tableNames | 
ForEach-Object {
    # cycles through each tables Captured in the previous query
    $table = $_
    $query = "SELECT * from [$database_name].[$schema_name2].[$_]"
    (Invoke-Sqlcmd -Query $query -ServerInstance $server_instance) | 
    # Save the resulting table in it's own file with the table name
    Out-File C:\Temp\SQLTables\$table.log
}

Write-Output "...the script has now completed. Please review the table content in C:\Temp\`$table.log"


<# 
PS C:\Users\Administrator> $table = 'vault'
PS C:\Users\Administrator> Invoke-Sqlcmd -Query "SELECT * from Vault.dbo.$table" -ServerInstance "TCDTemp\Evault_db"


VaultID        : 47180048
HostName       : TCDTemp
Domain         :
NetworkAddress :
Description    : VMware-42 15 8e 97 a3 f1 c3 e2-6b e1 73 4d 3e c4 d9 1c
CreationDate   : 3/16/2023 5:00:56 PM
GUID           : b018f3a1-caf4-413d-96ce-dc7a99afd2ff
Replicated     :
DedupType      : T



PS C:\Users\Administrator> 
#>


