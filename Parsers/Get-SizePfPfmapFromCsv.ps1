## Get-SizePfPfmapFromCsv.ps1 v 0.0.1 on 10/11/2018
# based on DFC collected list_files.csv for 1 task, calculate the size of all the .pf and .pf-map files in that csv

$a = ipcsv "C:\Temp\04xxxxxx\01434567\DFC-01434567-Sat-2018-10-11-10-36-19-680\Tasks\List Files\list_files.csv"
PS C:\Temp\04xxxxxx\01434567\DFC-01434567-Sat-2018-10-11-10-36-19-680\Tasks\List Files> $a | select -First 10

<#
H1               :
File path        : C:\Vault123456789\Agent1_1\Backup1\00000001.pf
Size in Bytes    : 281916770
Create Time      : 24.02.2018 06:18:28
Last Access Time : 24.02.2018 06:18:28
Last Update Time : 24.02.2018 06:18:36

H1               :
File path        : C:\Vault123456789\Agent1_1\Backup1\00000001.pf-map
Size in Bytes    : 1699587
Create Time      : 24.02.2018 06:18:28
Last Access Time : 24.02.2018 06:18:28
Last Update Time : 24.02.2018 06:18:37
#>

$b = 0
$a | where {$_."File path" -match ".\.pf*"} | foreach {$b = $b + $_."Size in bytes"}
Write-Output "Size in GB:"
$b / 1024 / 1024 / 1024



<#
WARNING: One or more headers were not specified. Default names starting with "H" have been used in place of any missing headers.
Get-Process : A positional parameter cannot be found that accepts argument 'Files>'.
At C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-SizePfPfmapFromCsv.ps1:2 char:1
+ PS C:\Temp\04xxxxxx\01434567\DFC-01434567-Sat-2018-10-11-10-3 ...
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : InvalidArgument: (:) [Get-Process], ParameterBindingException
    + FullyQualifiedErrorId : PositionalParameterNotFound,Microsoft.PowerShell.Commands.GetProcessCommand

Size in GB:\n
181.815249552019
#>