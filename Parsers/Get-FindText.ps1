﻿<#
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
            use profile PROFILE
        Profile   : PROFILE
        rf-domain : DOMAIN
        hostname  : ACCESSPOINT
        area      : inside


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
        rf-domain   NoteProperty string rf-domain=DOMAIN