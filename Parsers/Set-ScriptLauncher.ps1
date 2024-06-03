# Block comment out the Scripts you do not want to run
# Example to only run : ExtractNfoFromAFC
# $Selector = @(<# Get-MSInfo, #> "ExtractNfoFromAFC")
# Make sure to place th switch keywords in double quotes
$Selector = @(<# "Get-MSInfo", #> 
<# "ExtractNfoFromAFC", #> 
<# "SpecificAFC", #> 
"StandardAFC",
"StandardDFC" ,
"StandardPFC")

$Selector | ForEach-Object {
	switch ($_)
	{
		"Get-MSInfo" {
			#Application Event			
            # Get-MSinfo.ps1 now resets arrays to allow for multiple .nfo to be handled. Get-MSINFOTOO.ps1 passes those multipe *.nfo files to it.

            . $env:HOMEPATH\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-MSInfo.ps1
            Get-ChildItem C:\Temp\msinfo32_de.nfo -Filter *.nfo -Recurse | Select-Object -Property FullName | Get-MSInfo   
            break
		}
		"ExtractNfoFromAFC" {
			# System Event
			# Create a list of all the AFC*.zip files we have copied to this path to only extract *.nfo files
			Get-ChildItem C:\Temp\06xxxxxx\2024\*.zip -Filter *.zip | ForEach-Object { $_ | C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-AFCMSINFO.ps1}
			break
		}
		"SpecificAFC" {
			# System Event
			# Create a list of all the AFC*.zip files we have copied to this path to only extract *.nfo files
			Get-ChildItem -LiteralPath "C:\Temp\AFC-01234567-TCEVR274-2024-05-31-12-43-38-460.zip" | ForEach-Object { $_ | C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-AFCMSINFO.ps1}
			break
		}
		"StandardAFC" {
			# System Event
			# Only extracts this AFC
			Get-ChildItem -LiteralPath "C:\Temp\AFC-01234567-TCEVR274-2024-05-31-12-43-38-460.zip" | ForEach-Object { $_ | C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-AFC.ps1}
			break
		}
		"StandardDFC" {
			# System Event
			# Only extracts this DFC
			Get-ChildItem -LiteralPath "C:\Temp\DFC-TCD1-2024-06-03-02-17-36-401.zip" | ForEach-Object { $_ | C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-DFC.ps1}
			break
		}
		"StandardPFC" {
			# System Event
			# Only extracts this DFC
			Get-ChildItem -LiteralPath "C:\Temp\PFC-TCPortalAi1-2024-06-03-06-05-41-965.zip" | ForEach-Object { $_ | C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-PFC.ps1}
			break
		}

		default {
			# checking content of $_ as seen by the switch statement
			# What did not get selected by switch
			break
		}
	}
}


Write-Host "...Application and System logs filtered filtering completed"
