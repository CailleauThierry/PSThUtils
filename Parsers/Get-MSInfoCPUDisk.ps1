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
        [string]$msinfo32File
    )
    
    begin {
        $Drives = @()
        [xml]$msinfo = Get-Content $msinfo32File
    }
    
    process {
        $msinfo.MsInfo.Category.Category[1].Category[9].Category[0].Data | 
        ForEach-Object {$Drives += ,@{($_.Item.OuterXml.Replace('<Item><![CDATA[','').Replace(']]></Item>',''))=($_.Value.OuterXml.Replace('<Value><![CDATA[','').Replace(']]></Value>',''))}}

#$msinfo.MsInfo.Category.Category[1].Category[9].Category[0].Data | 
#ForEach-Object {$Drives.Add($_.Item.OuterXml.Replace('<Item><![CDATA[','').Replace(']]></Item>',''),$_.Value.OuterXml.Replace('<Value><![CDATA[','').Replace(']]></Value>',''))}
    }
    
    end {
        return $Drives
    }
}
Get-MSInfo -msinfo32File 'C:\Temp\06xxxxxx\02824089\05_07_2024\AFC-_02824089-SVIMGCAVW101.backup.lan-2024-05-07-11-42-23-279_1715075058\msinfo32.nfo' | 
Out-String -Stream | Where-Object {$_ -match 'Size|Drive|Disc'}   






