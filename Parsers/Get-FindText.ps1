<#
    .NOTES
    ===========================================================================
    Created on:   	Friday February 17, 2017
    Created by:   	CailleauThierry
    Organization: 	Private
    Filename:		Get-FindText.ps1
    Version:        0.0.0.1
    Started from: 	http://stackoverflow.com/questions/12572164/multiline-regex-to-match-config-block
    ===========================================================================
    .DESCRIPTION
        Find different strings in text using RegEx
    .EXAMPLE
        ./Get-FindText.ps1
	.FUNCTIONALITY
        Find different strings in text using RegEx
    .NOTES
        test.txt
            ap71xx 00-01-23-45-67-89
            use profile PROFILE        use rf-domain DOMAIN        hostname ACCESSPOINT        area inside        !        Results from ./Get-FindText.ps1        Mac       : 00-01-23-45-67-89
        Profile   : PROFILE
        rf-domain : DOMAIN
        hostname  : ACCESSPOINT
        area      : inside        Where        $varObjs | gm  :


           TypeName: System.Object

        Name        MemberType   Definition                    
        ----        ----------   ----------                    
        Equals      Method       bool Equals(System.Object obj)
        GetHashCode Method       int GetHashCode()             
        GetType     Method       type GetType()                
        ToString    Method       string ToString()             
        area        NoteProperty string area=inside            
        hostname    NoteProperty string hostname=ACCESSPOINT   
        Mac         NoteProperty string Mac=00-01-23-45-67-89  
        Profile     NoteProperty string Profile=PROFILE        
        rf-domain   NoteProperty string rf-domain=DOMAIN#>$Lines = Get-Content "c:\posh\input\test.txt"$varObjs = @()for ($num = 0; $num -lt $lines.Count; $num =$varLast ) {    #Checks to make sure the line isn't blank or a !. If it is, it skips to next line    if ($Lines[$num] -match "!") {        $varLast++        continue    }    if (([regex]::Match($Lines[$num],"^\s.*$")).success) {        $varLast++        continue    }    $Index = [array]::IndexOf($lines, $lines[$num])    $b=0    $varObj = New-Object System.Object    while ($Lines[$num + $b] -notmatch "!" ) {        #Checks line by line to see what it matches, adds to the $varObj when it finds what it wants.        if ($Lines[$num + $b] -match "ap") { $varObj | Add-Member -MemberType NoteProperty -Name Mac -Value $([regex]::Split($lines[$num + $b],"\s"))[1] }        if ($lines[$num + $b] -match "profile") { $varObj | Add-Member -MemberType NoteProperty -Name Profile -Value $([regex]::Split($lines[$num + $b],"\s"))[3] }        if ($Lines[$num + $b] -match "domain") { $varObj | Add-Member -MemberType NoteProperty -Name rf-domain -Value $([regex]::Split($lines[$num + $b],"\s"))[3] }        if ($Lines[$num + $b] -match "hostname") { $varObj | Add-Member -MemberType NoteProperty -Name hostname -Value $([regex]::Split($lines[$num + $b],"\s"))[2] }        if ($Lines[$num + $b] -match "area") { $varObj | Add-Member -MemberType NoteProperty -Name area -Value $([regex]::Split($lines[$num + $b],"\s"))[2] }        $b ++    } #end While    #Adds the $varObj to $varObjs for future use    $varObjs += $varObj    $varLast = ($b + $Index) + 2}#End for ($num = 0; $num -lt $lines.Count; $num = $varLast)#displays the $varObjs$varObjs
