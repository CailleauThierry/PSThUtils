<# 
PS C:\Users\Administrator> Get-ItemProperty HKCU:\Software\Classes\github-windows\shell\open\command -Name '(default)'


(default)    : "C:\Users\Administrator\AppData\Local\GitHubDesktop\app-3.1.3\GitHubDesktop.exe" "--protocol-launcher" "%1"
PSPath       : Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\Software\Classes\github-windows\shell\open\command
PSParentPath : Microsoft.PowerShell.Core\Registry::HKEY_CURRENT_USER\Software\Classes\github-windows\shell\open
PSChildName  : command
PSDrive      : HKCU
PSProvider   : Microsoft.PowerShell.Core\Registry



PS C:\Users\Administrator> (Get-ItemProperty HKCU:\Software\Classes\github-windows\shell\open\command -Name '(default)').'(default)'
"C:\Users\Administrator\AppData\Local\GitHubDesktop\app-3.1.3\GitHubDesktop.exe" "--protocol-launcher" "%1"
PS C:\Users\Administrator> ((Get-ItemProperty HKCU:\Software\Classes\github-windows\shell\open\command -Name '(default)').'(default)' -split 'GitHubDesktop.exe')[0]
"C:\Users\Administrator\AppData\Local\GitHubDesktop\app-3.1.3\
PS C:\Users\Administrator> ((Get-ItemProperty HKCU:\Software\Classes\github-windows\shell\open\command -Name '(default)').'(default)' -split 'GitHubDesktop.exe')[0].Split('"')[1]
C:\Users\Administrator\AppData\Local\GitHubDesktop\app-3.1.3\
PS C:\Users\Administrator> #>

$GitHubDesktopRoot = ((Get-ItemProperty HKCU:\Software\Classes\github-windows\shell\open\command -Name '(default)').'(default)' -split 'GitHubDesktop.exe')[0].Split('"')[1]
# PS C:\Users\Administrator\Documents\WindowsPowerShell\Scripts\PSThUtils> $GitHubDesktopPath
# C:\Users\Administrator\AppData\Local\GitHubDesktop\app-3.2.7\
# I want this script to work even if the user is not logged in as Administrator i.e. use the  %homepath% environment variable > the plan is toupdate the environment variable itself
$GitHubDesktopUpdatedPath= '%homepath%\AppData' + [regex]::split($GitHubDesktopRoot,'\\AppData')[1] + 'resources\app\git\mingw64\bin'

<# 
PS C:\Users\Administrator\Documents\WindowsPowerShell\Scripts\PSThUtils> '%homepath%\AppData' + [regex]::split($GitHubDesktopPath,'\\AppData')[1]

%homepath%\AppData\Local\GitHubDesktop\app-3.2.7\ 
#>

# \resources\app\git\cmd

# %homepath%\AppData\Local\GitHubDesktop\app-3.2.7\resources\app\git\mingw64\bin\
# C:\Users\Administrator\AppData\Local\GitHubDesktop\app-3.2.6\resources\app\git\cmd
$GitHubDesktopPath = 0

$GitHubDesktopPath = [Environment]::GetEnvironmentVariable("PATH", "Machine").
split(';') | Where-Object{$_ -match '.*GitHubDesktop\\app-.*'}

if ([Environment]::GetEnvironmentVariable("PATH", "Machine").
split(';') | Where-Object{$_ -match '.*GitHubDesktop\\app-.*'}) {
    Write-Output "They is this GitHubDesktop\app- path in the System Environment Variable:`n $GitHubDesktopPath"
    $Path = [Environment]::GetEnvironmentVariable("PATH", "Machine")
    $Path = $Path.Replace("$GitHubDesktopPath","$GitHubDesktopUpdatedPath")
    [Environment]::SetEnvironmentVariable( "Path", $Path, "Machine" )
}
else{
    Write-Output "They is no existing GitHubDesktop\app- path in the System Environment Variable"
    $Path = $GitHubDesktopUpdatedPath
    $Path = [Environment]::GetEnvironmentVariable("PATH", "Machine") + $Path
    [Environment]::SetEnvironmentVariable( "Path", $Path, "Machine" )
}

<# C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C
:\Program Files\Microsoft SQL Server\Client SDK\ODBC\130\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\140\Tools\Binn\;C
:\Program Files\Microsoft SQL Server\140\Tools\Binn\;C:\Program Files\Microsoft SQL Server\140\DTS\Binn\;C:\ProgramData\chocolatey
\bin;C:\Program Files\Microsoft VS Code\bin;C:\Users\Administrator\AppData\Local\GitHubDesktop\app-3.1.3\resources\app\git\cmd\;C:
\Program Files (x86)\Microsoft SQL Server\160\DTS\Binn\;C:\Program Files\Azure Data Studio\bin;C:\Program Files\Microsoft SQL Serv
er\Client SDK\ODBC\170\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\150\Tools\Binn\;C:\Program Files\Microsoft SQL Serv
er\150\Tools\Binn\;C:\Program Files\Microsoft SQL Server\150\DTS\Binn\;C:\Users\Administrator\AppData\Local\Microsoft\WindowsApps;
C:\Users\Administrator\AppData\Local\GitHubDesktop\bin;C:\Program Files\Azure Data Studio\bin;C:\Program Files\OpenSSL-Win64\bin;
PS C:\Users\Administrator\Documents\WindowsPowerShell\Scripts\PSThUtils> $env:Path.Replace('GitHubDesktop\app-3.1.3','GitHubDeskto
p\app-3.2.8')
C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Windows\System32\OpenSSH\;C
:\Program Files\Microsoft SQL Server\Client SDK\ODBC\130\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\140\Tools\Binn\;C
:\Program Files\Microsoft SQL Server\140\Tools\Binn\;C:\Program Files\Microsoft SQL Server\140\DTS\Binn\;C:\ProgramData\chocolatey
\bin;C:\Program Files\Microsoft VS Code\bin;C:\Users\Administrator\AppData\Local\GitHubDesktop\app-3.2.8\resources\app\git\cmd\;C:
\Program Files (x86)\Microsoft SQL Server\160\DTS\Binn\;C:\Program Files\Azure Data Studio\bin;C:\Program Files\Microsoft SQL Serv
er\Client SDK\ODBC\170\Tools\Binn\;C:\Program Files (x86)\Microsoft SQL Server\150\Tools\Binn\;C:\Program Files\Microsoft SQL Serv
er\150\Tools\Binn\;C:\Program Files\Microsoft SQL Server\150\DTS\Binn\;C:\Users\Administrator\AppData\Local\Microsoft\WindowsApps;
C:\Users\Administrator\AppData\Local\GitHubDesktop\bin;C:\Program Files\Azure Data Studio\bin;C:\Program Files\OpenSSL-Win64\bin;
PS C:\Users\Administrator\Documents\WindowsPowerShell\Scripts\PSThUtils> #>

C:\Users\Administrator\AppData\Local\GitHubDesktop\app-3.2.8\resources\app\git\mingw64\bin