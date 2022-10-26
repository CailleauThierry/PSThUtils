# xtranslate_18.ps1 based on xtranslate_18.ps1 > changed the end message
Set-StrictMode -Version 2

# creating a (xtranslate_15.exe.config + xtranslate_15.exe) let you drag/drop multiple .xlog and it will translate them
# can drag drop from source location and will create .log there
# assumes XLogTranslator.exe is installed in C:\Program Files\Carbonite Server Backup\Agent\
function Get-XLogTranslator{

	begin {
	Write-OutPut "begin: This function expects an .xlog file as a pipeline input Get-ChildItem Your_Path\*.XLOG"
	}
	process {
	# runs once per pipeline object pipeline object
	# here $_. represents the .XLOG file
	Write-OutPut "Input is:  $_"
	&'C:\Program Files\Carbonite Server Backup\Agent\XLogTranslator.exe' $_ /l "en-US" /o "$_.log"
	Write-OutPut "Output is: $_.log"
	}
	end {
	Write-OutPut "end: This function writes a translated xlog.log to Your_Path\*.XLOG.log and displays it to the Pipe"
	}
}
Clear-Host
#Get-ChildItem C:\hsgTest\input\*.XLOG | Get-XLogTranslator 
# Get-Content C:\hsgTest\input\*.log
# Remove-Item C:\hsgTest\input\*.log	# going through cycles, so removing is part of the test
# actual working results
#PS C:\posh\projects\xtrans> Get-ChildItem "C:\Users\tcailleau\Documents\EMEA_files\Temp\006xxxxx\0061xxxx\00612318 VRA Freeze\support-bundle-20141202-104101\BUAgent\*\*.XLOG" -Recurse | Get-XLogTranslator
#begin: This function expects an .xlog file as a pipeline input Get-ChildItem Your_Path\*.XLOG
#Input is:  C:\Users\tcailleau\Documents\EMEA_files\Temp\006xxxxx\0061xxxx\00612318 VRA Freeze\support-bundle-20141202-104101\BUAgent\VRA-JOB-401\00000006.XLOG
#Output is: C:\Users\tcailleau\Documents\EMEA_files\Temp\006xxxxx\0061xxxx\00612318 VRA Freeze\support-bundle-20141202-104101\BUAgent\VRA-JOB-401\00000006.XLOG.log