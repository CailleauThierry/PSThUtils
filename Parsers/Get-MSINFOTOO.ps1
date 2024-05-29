# Get-MSinfo.ps1 now resets arrays to allow for multiple .nfo to be handled. Get-MSINFOTOO.ps1 passes those multipe *.nfo files to it.

. $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-MSInfo.ps1
Get-ChildItem C:\Temp\06xxxxxx\2024\*.nfo -Filter *.nfo -Recurse | Select-Object -Property FullName | Get-MSInfo   