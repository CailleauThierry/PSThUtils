
<#
.SYNOPSIS
    Get-DotNetVersion.ps1 a self-called function that does not take any input paramerters and reads the registries to provide the P.NET Framework version
.DESCRIPTION
    self-called function that does not take any input paramerters and reads the registries to provide the P.NET Framework version
    Tested on  on Win 11 Enterprise Version 10.0.22621 Build 22621

.NOTES
    Information or caveats about the function e.g. 'This function is not supported in Linux'
.LINK
    From https://learn.microsoft.com/en-us/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed Detect .NET Framework 4.5 and later versions""
.EXAMPLE
    ./Get-DotNetVersion.ps1
    PS C:\Users\Administrator\Documents\WindowsPowerShell\Scripts\PSThUtils> . 'C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils\Utils\Get-DotNetVersion.ps1'
.NET Framework Version: 4.8.1 or later
#>


function Get-DotNetVersion {
    [CmdletBinding()]
    param (
        
    )
    
    begin {
        $release = Get-ItemPropertyValue -LiteralPath 'HKLM:SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full' -Name Release

    }
    
    process {
        switch ($release) {
            { $_ -ge 533320 } { $version = '4.8.1 or later'; break }
            { $_ -ge 528040 } { $version = '4.8'; break }
            { $_ -ge 461808 } { $version = '4.7.2'; break }
            { $_ -ge 461308 } { $version = '4.7.1'; break }
            { $_ -ge 460798 } { $version = '4.7'; break }
            { $_ -ge 394802 } { $version = '4.6.2'; break }
            { $_ -ge 394254 } { $version = '4.6.1'; break }
            { $_ -ge 393295 } { $version = '4.6'; break }
            { $_ -ge 379893 } { $version = '4.5.2'; break }
            { $_ -ge 378675 } { $version = '4.5.1'; break }
            { $_ -ge 378389 } { $version = '4.5'; break }
            default { $version = $null; break }
        }
    }
    
    end {
        if ($version) {
            Write-Host -Object ".NET Framework Version: $version"
        } else {
            Write-Host -Object '.NET Framework Version 4.5 or later is not detected.'
        }
    }
}

Get-DotNetVersion