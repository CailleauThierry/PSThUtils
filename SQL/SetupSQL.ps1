# SetupSQL.ps1 ----------------------------------
# Based on: https://sudeeptaganguly.wordpress.com/2012/03/14/installing-sql-server-2012/
 
# The Base Command for unattend installation of SQL Server 2012
 
# Define Variables
$SetupLocation = "D:\Setup.exe"

# New SQL Server Hostname
$Hostname = "xxxx"

# Provide the SA Password
$SAPWD = "xxxxxxxx"

# Provide the Database Engine Service Account Password, not needed when "NT AUTHORITY\NETWORK SERVICE" is used
# $SQLSVCPASSWORD = "xxxxxxxx"

# Provide the SQL Agent Service Account Password , not needed when "NT AUTHORITY\NETWORK SERVICE" is used
# $AGTSVCPASSWORD = "xxxxxxxx"

# Windows account(s) to provision as SQL Server system administrators. 
$SQLSYSADMINACCOUNTS="$Hostname\Administrator"
 
$ConfigFileLocation = "C:\ConfigurationFiles\ConfigurationFile.ini"
 
# Change the current folder location to C:\ConfigurationFiles
Set-Location "C:\ConfigurationFiles"
 
# To start the SQL Server Installation
& "$SetupLocation" /IACCEPTSQLSERVERLICENSETERMS /SQLSYSADMINACCOUNTS=$SQLSYSADMINACCOUNTS /SAPWD="$SAPWD" /CONFIGURATIONFILE="$ConfigFileLocation" 

# removed '/AGTSVCPASSWORD="$AGTSVCPASSWORD"' A password was specified for the Windows well-known NT account NT AUTHORITY\NETWORK SERVICE. No password should be specified.
# removed '/SQLSVCPASSWORD="$SQLSVCPASSWORD"' A password was specified for the Windows well-known NT account NT AUTHORITY\NETWORK SERVICE. No password should be specified.