<#
.SYNOPSIS
    Get-MSinfoCPUDisk.ps1 implements the function Get-MSInfo which parse msinfo32.nfo files
.DESCRIPTION
    The plan is to extract the number of Drives and their size, the number of CPUs and the size of the RAM
.NOTES
    Information or caveats about the function e.g. 'This function is not supported in Linux'
.LINK
    Specify a URI to a help page, this will show when Get-Help -Online is used.
.EXAMPLE
    Test-MyTestFunction -Verbose
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
#>

function Get-MSInfo {
    [CmdletBinding()]
    param (
    [Parameter(
	Mandatory=$true,
	ValueFromPipeline=$true
	)
    ] 
    [string]$msinfo32File
    )
    
    begin {
        $Drives = @()
        [xml]$msinfo = Get-Content $msinfo32File
    }
    
    process {
        $msinfo.MsInfo.Category.Category[1].Category[9].Category[0].Data | 
        ForEach-Object {$Drives += ,@{($_.Item.OuterXml.Replace('<Item><![CDATA[','').Replace(']]></Item>',''))=($_.Value.OuterXml.Replace('<Value><![CDATA[','').Replace(']]></Value>',''))}} 
        $myDrives += $Drives | Out-String -Stream | Where-Object {$_ -match 'Size.*'} 
    }
    
    end {
 
        $myDrives | Out-File ($msinfo32File + ".log")
    }
}
 Get-MSInfo -msinfo32File 'C:\Temp\06xxxxxx\2024\Extracted\AFC-100796-PDMSQL01.dtric.com-2024-05-06-07-55-24-893\msinfo32.nfo'




