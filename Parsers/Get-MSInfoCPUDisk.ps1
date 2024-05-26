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
        #Getting main page info
        $msinfo.MsInfo.Category.Data |
        ForEach-Object {$Drives += ,@{($_.Item.OuterXml.Replace('<Item><![CDATA[','').Replace(']]></Item>',''))=($_.Value.OuterXml.Replace('<Value><![CDATA[','').Replace(']]></Value>',''))}} 
        # Getting Components > Storage > Drives info
        $msinfo.MsInfo.Category.Category[1].Category[9].Category[0].Data | 
        ForEach-Object {$Drives += ,@{($_.Item.OuterXml.Replace('<Item><![CDATA[','').Replace(']]></Item>',''))=($_.Value.OuterXml.Replace('<Value><![CDATA[','').Replace(']]></Value>',''))}} 

        $myDrives += $Drives | Out-String -Stream
    
    }
    
    end {
 
        $myDrives | Out-File ($msinfo32File + ".log")
    }
}
 Get-MSInfo -msinfo32File 'C:\Temp\06xxxxxx\2024\Extracted\AFC-02732663-New-MailArchiver.eccu.local-2024-01-03-14-26-46-694\msinfo32.nfo'




