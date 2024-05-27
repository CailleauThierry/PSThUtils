. C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-MSInfoCPUDisk.ps1
Get-ChildItem C:\Temp\06xxxxxx\2024\Extracted\*.nfo -Filter *.nfo -Recurse | ForEach-Object {Get-MSInfo -msinfo32File ($_.FullName)}
