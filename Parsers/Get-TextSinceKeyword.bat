rem %~dp0 is the path of the batch file
@ECHO OFF
PowerShell.exe -NoProfile -Command "& {Start-Process PowerShell.exe -ArgumentList '-ExecutionPolicy Bypass -File "%~dp0\MyPowerShell Script.ps1"'-Verb RunAs}"
PAUSE