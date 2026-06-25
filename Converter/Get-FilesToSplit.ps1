<#
	.SYNOPSIS
		Get-FilesToSplit.ps1 on 08/22/2025 version 0.1 is based on Get-EBCDICToASCII.ps1 to capture the file
	
	.DESCRIPTION
		Takes a text file asuming you know it is encoding in IBM EBCDIC format and create a same file name in same location with _to_ASCII.txt extension in Windows readable ASCII format
	.EXAMPLE
		Drag&Drop of the EBCDIC log file to the script shotcut. It takes the full path from it and create a same name same location with added extention _to_ASCII.txt

	.INPUTS
		Any IBM EBCDIC formatted log file

	.OUTPUTS
		TypeName: System.String > to the file system 

	.NOTES
		This is version 0.1 working

	.LINK
		about_comment_based_help

#>


param ( 
[Parameter(mandatory=$true,HelpMessage='Needs full path to file to parse')][string] $SourceFileName
)


# Define the input file and output file paths
$outputFile1 = (($SourceFileName).ToString()) + "_ASCII.txt"  # First part (up to column 52)
$outputFile2 = (($SourceFileName).ToString()) + "_EBCDIC.txt"  # Second part (from column 53 onward)

# Ensure the output files are empty before writing
Clear-Content -Path $outputFile1 -ErrorAction SilentlyContinue
Clear-Content -Path $outputFile2 -ErrorAction SilentlyContinue

# Read the input file line by line
Get-Content $SourceFileName | ForEach-Object {
    # Split the line into two parts
    $linePart1 = $_.Substring(0, [math]::Min(52, $_.Length))  # Up to column 52
    $linePart2 = if ($_.Length -gt 52) { $_.Substring(52) } else { "" }  # From column 53 onward

    # Write the parts to their respective output files
    Add-Content -Path $outputFile1 -Value $linePart1
    Add-Content -Path $outputFile2 -Value $linePart2
}
Write-Host "File has been split into two parts: $outputFile1 and $outputFile2"
<# 
Generated via Copilot using GPT-4o          

I asked:
I have a text with 2 different formats. I need a Powershell script which will split this file in 2 at column 52

It responded with the below code:
"
To split a text file into two separate files at column 52, you can use the following PowerShell script. This script reads the input file line by line, splits each line into two parts (up to column 52 and from column 53 onward), and writes the results into two separate output files.

Here’s the script:
"
# Define the input file and output file paths
$inputFile = "C:\path\to\your\inputFile.txt"
$outputFile1 = "C:\path\to\outputFile1.txt"  # First part (up to column 52)
$outputFile2 = "C:\path\to\outputFile2.txt"  # Second part (from column 53 onward)

# Ensure the output files are empty before writing
Clear-Content -Path $outputFile1 -ErrorAction SilentlyContinue
Clear-Content -Path $outputFile2 -ErrorAction SilentlyContinue

# Read the input file line by line
Get-Content $inputFile | ForEach-Object {
    # Split the line into two parts
    $linePart1 = $_.Substring(0, [math]::Min(52, $_.Length))  # Up to column 52
    $linePart2 = if ($_.Length -gt 52) { $_.Substring(52) } else { "" }  # From column 53 onward

    # Write the parts to their respective output files
    Add-Content -Path $outputFile1 -Value $linePart1
    Add-Content -Path $outputFile2 -Value $linePart2
}

Write-Host "File has been split into two parts: $outputFile1 and $outputFile2"

"
Explanation:
Input and Output Files:

Replace C:\path\to\your\inputFile.txt with the path to your input file.
Replace C:\path\to\outputFile1.txt and C:\path\to\outputFile2.txt with the desired paths for the output files.
Splitting Logic:

Substring(0, 52) extracts the first 52 characters of the line.
Substring(52) extracts the remaining characters starting from column 53.
If the line is shorter than 52 characters, it handles it gracefully.
Writing to Files:

Add-Content appends the split parts to their respective output files.
Clear-Content:

Ensures the output files are empty before appending new content.
How to Run:
Save the script to a .ps1 file (e.g., SplitFile.ps1).
Open PowerShell and navigate to the directory containing the script.
Run the script: .\SplitFile.ps1.
After running the script, you will have two output files:

outputFile1.txt containing the first 52 columns of each line.
outputFile2.txt containing the remaining columns starting from column 53.
"

I inserted in in a code that was asking for an input file and it worked!
#>