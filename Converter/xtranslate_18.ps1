# xtranslate_18.ps1 based on xtranslate_18.ps1 > changed the end message > changed path to "Carbonite Server Backup" instead of "EVault Software" > removed PS2 strict
param (
[Parameter(mandatory=$true)][string] $SourceFileName
)

# creating a (xtranslate_15.exe.config + xtranslate_15.exe) let you drag/drop multiple .xlog and it will translate them
# can drag drop from source location and will create .log there
# assumes XLogTranslator.exe is installed in C:\Program Files\EVault Software\Agent\
function Get-XLogTranslator{

	begin {
	Write-OutPut "begin: This function expects an .xlog file as a pipeline input Get-ChildItem Your_Path\*.XLOG"
	}
	process {
	# runs once pe pipeline object pipeline object
	# here $_. represnets the

	&'C:\Program Files\Carbonite Server Backup\Agent\XLogTranslator.exe' $_ /o "$_.log"
	Write-OutPut "Input is:  $_"
	Write-OutPut "Output is: $_.log"
	}
	end {
	Write-OutPut "end: This function writes a translated xlog.log to Your_Path\*.XLOG.log and displays it to the Pipe"
	}
}

Get-ChildItem $SourceFileName -Filter *.xlog -Recurse | Select-Object $_.FullName | Get-XLogTranslator

