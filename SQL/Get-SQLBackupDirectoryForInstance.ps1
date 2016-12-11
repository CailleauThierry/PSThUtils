<#
	.SYNOPSIS
		A brief description of the Get-SQLBackupDirectoryForInstance.ps1 file.

	.DESCRIPTION
		This extract the Backup Directory folder for the instance you give it
	
	.PARAMETER  InstanceName
		The description of a the InstanceName parameter.

	.PARAMETER  Host
		The description of a the Host parameter.

	.EXAMPLE
		PS C:\> $res = Get-SQLBackupDirectoryForInstance -InstanceName Instance1
		PS C:\> Write-Output "$res"
		C:\Program Files\Microsoft SQL Server\MSSQL11.INSTANCE1\MSSQL\Backup
		This example shows how to call a function with the mandatory SQL Instance Name only.
		Verbose is supported for script debugging

	.EXAMPLE
		PS C:\> $res = Get-SQLBackupDirectoryForInstance -InstanceName Instance1 -Host_Name Clone1
		PS C:\> Write-Output "$res"
		C:\Program Files\Microsoft SQL Server\MSSQL11.INSTANCE1\MSSQL\Backup
		This example shows how to call a function with the mandatory SQL Instance Name and Server Host Name.
		Verbose is supported for script debugging

	.INPUTS
		System.String,System.Int32

	.OUTPUTS
		System.String

	.NOTES
		For more information about advanced functions, call Get-Help with any
		of the topics in the links listed below.

	.NOTES
		===========================================================================
		Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2016 v5.2.129
		Created on:   	11/14/2016 10:54 AM
		Created by:   	CailleauThierry
		Organization: 	Private
		Filename:     	Get-SQLBackupDirectoryForInstance.ps1
		===========================================================================

	.NOTES
		Got original idea from http://sqlblog.com/blogs/allen_white/archive/2009/02/19/finding-your-default-file-locations-in-smo.aspx
	.LINK
		about_functions_advanced

	.LINK
		about_comment_based_help

	.LINK
		about_functions_advanced_parameters

	.LINK
		about_functions_advanced_methods
#>
function Get-SQLBackupDirectoryForInstance{
	[CmdletBinding()]
	param(
		[Parameter(Position=0, Mandatory=$true)]
		[System.String]
		$InstanceName,
		[Parameter(Position=1)]
		[System.String]
		$Host_Name = 'YourHostName'
	)
	
	process
	{
		try
		{
			[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.SqlServer.SMO') | out-null
			if ($Host_Name = 'YourHostName')
			{
				$Host_Name = $env:computername
				Write-Verbose "The script took the local hostname from `$env:computername"
			}
			$sqlserver = $Host_Name + "\" + $InstanceName
			#create a new server object
			$server = New-Object ("Microsoft.SqlServer.Management.Smo.Server") "$sqlserver"
			#display default backup directory for debugging
			return $server.Settings.BackupDirectory
		}
		catch
		{
			Write-Verbose "SQL Object Creation did not work"
		}
	}
}

$res = Get-SQLBackupDirectoryForInstance -InstanceName Instance1 -Verbose
Write-Output "$res"

<#>> Running (Get-SQLBackupDirectoryForInstance.ps1) Script...
>> Platform: V3 64Bit (STA)
VERBOSE: The script took the local hostname from $env:computername
C:\Program Files\Microsoft SQL Server\MSSQL11.INSTANCE1\MSSQL\Backup

>> Execution time: < 1 second
>> Script Ended#>
