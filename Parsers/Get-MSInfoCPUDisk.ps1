# Get-MSinfoCPUDisk.ps1 first draft on Saturday May 25, 2024

# PS C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils> [xml]$msinfo = Get-Content C:\Temp\06xxxxxx\02824089\05_07_2024\AFC-_02824089-SVIMGCAVW101.backup.lan-2024-05-07-11-42-23-279_1715075058\msinfo32.nfo
# PS C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils> $msinfo | gm                                      
                            

#    TypeName: System.Xml.XmlDocument

# Name                        MemberType            Definition
# ----                        ----------            ----------
# ToString                    CodeMethod            static string XmlNode(psobject instance)
# AppendChild                 Method                System.Xml.XmlNode AppendChild(System.Xml.XmlNode newChild)
# Clone                       Method                System.Xml.XmlNode Clone(), System.Object ICloneable.Clone()        
# CloneNode                   Method                System.Xml.XmlNode CloneNode(bool deep)
# CreateAttribute             Method                System.Xml.XmlAttribute CreateAttribute(string name), System.Xml.... 
# CreateCDataSection          Method                System.Xml.XmlCDataSection CreateCDataSection(string data)
# CreateComment               Method                System.Xml.XmlComment CreateComment(string data)
# CreateDocumentFragment      Method                System.Xml.XmlDocumentFragment CreateDocumentFragment()
# CreateDocumentType          Method                System.Xml.XmlDocumentType CreateDocumentType(string name, string... 
# CreateElement               Method                System.Xml.XmlElement CreateElement(string name), System.Xml.XmlE... 
# CreateEntityReference       Method                System.Xml.XmlEntityReference CreateEntityReference(string name)     
# CreateNavigator             Method                System.Xml.XPath.XPathNavigator CreateNavigator(), System.Xml.XPa... 
# CreateNode                  Method                System.Xml.XmlNode CreateNode(string nodeTypeString, string name,... 
# CreateProcessingInstruction Method                System.Xml.XmlProcessingInstruction CreateProcessingInstruction(s... 
# CreateSignificantWhitespace Method                System.Xml.XmlSignificantWhitespace CreateSignificantWhitespace(s... 
# CreateTextNode              Method                System.Xml.XmlText CreateTextNode(string text)
# CreateWhitespace            Method                System.Xml.XmlWhitespace CreateWhitespace(string text)
# CreateXmlDeclaration        Method                System.Xml.XmlDeclaration CreateXmlDeclaration(string version, st... 
# Equals                      Method                bool Equals(System.Object obj)
# GetElementById              Method                System.Xml.XmlElement GetElementById(string elementId)
# GetElementsByTagName        Method                System.Xml.XmlNodeList GetElementsByTagName(string name), System.... 
# GetEnumerator               Method                System.Collections.IEnumerator GetEnumerator(), System.Collection... 
# GetHashCode                 Method                int GetHashCode()
# GetNamespaceOfPrefix        Method                string GetNamespaceOfPrefix(string prefix)
# GetPrefixOfNamespace        Method                string GetPrefixOfNamespace(string namespaceURI)
# GetType                     Method                type GetType()
# ImportNode                  Method                System.Xml.XmlNode ImportNode(System.Xml.XmlNode node, bool deep)    
# InsertAfter                 Method                System.Xml.XmlNode InsertAfter(System.Xml.XmlNode newChild, Syste... 
# InsertBefore                Method                System.Xml.XmlNode InsertBefore(System.Xml.XmlNode newChild, Syst... 
# Load                        Method                void Load(string filename), void Load(System.IO.Stream inStream),... 
# LoadXml                     Method                void LoadXml(string xml)
# Normalize                   Method                void Normalize()
# PrependChild                Method                System.Xml.XmlNode PrependChild(System.Xml.XmlNode newChild)
# ReadNode                    Method                System.Xml.XmlNode ReadNode(System.Xml.XmlReader reader)
# RemoveAll                   Method                void RemoveAll()
# RemoveChild                 Method                System.Xml.XmlNode RemoveChild(System.Xml.XmlNode oldChild)
# ReplaceChild                Method                System.Xml.XmlNode ReplaceChild(System.Xml.XmlNode newChild, Syst... 
# Save                        Method                void Save(string filename), void Save(System.IO.Stream outStream)... 
# SelectNodes                 Method                System.Xml.XmlNodeList SelectNodes(string xpath), System.Xml.XmlN... 
# SelectSingleNode            Method                System.Xml.XmlNode SelectSingleNode(string xpath), System.Xml.Xml... 
# Supports                    Method                bool Supports(string feature, string version)
# Validate                    Method                void Validate(System.Xml.Schema.ValidationEventHandler validation... 
# WriteContentTo              Method                void WriteContentTo(System.Xml.XmlWriter xw)
# WriteTo                     Method                void WriteTo(System.Xml.XmlWriter w)
# Item                        ParameterizedProperty System.Xml.XmlElement Item(string name) {get;}, System.Xml.XmlEle... 
# MsInfo                      Property              System.Xml.XmlElement MsInfo {get;}
# xml                         Property              string xml {get;set;}


# PS C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils> $msinfo[0]  
# PS C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils> $msinfo[1]
# PS C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils> $msinfo

# xml           MsInfo
# ---           ------
# version="1.0" MsInfo


# PS C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils> $msinfo.MsInfo.Category.Category[1].Category[9].Category[0].Data | foreach {$_.Value}

# #cdata-section
# --------------
# A:
# 3 1/2 Inch Floppy Drive

# C:
# Local Fixed Disk
# No
# NTFS
# 59,16 GB (63.524.782.080 bytes)
# 28,59 GB (30.697.844.736 bytes)

# 364F1BFC

# D:
# Local Fixed Disk
# No
# NTFS
# 200,00 GB (214.745.153.536 bytes)
# 186,20 GB (199.934.672.896 bytes)
# New Volume
# E6140FE4

# E:
# CD-ROM Disc
# PS C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils> $msinfo.MsInfo.Category.Category[1].Category[9].Category[1].Data | foreach {$_.Value} 

# #cdata-section
# --------------
# Disk drive
# (Standard disk drives)
# VMware Virtual disk SCSI Disk Device
# 512
# Yes
# Fixed hard disk
# 1
# 0
# 0
# 0
# 1
# 63
# 200,00 GB (214.745.610.240 bytes)
# 26.108
# 419.425.020
# 6.657.540
# 255
# Disk #1, Partition #0
# 200,00 GB (214.745.219.072 bytes)
# 1.048.576 bytes

# Disk drive
# (Standard disk drives)
# VMware Virtual disk SCSI Disk Device
# 512
# Yes
# Fixed hard disk
# 3
# 0
# 0
# 0
# 0
# 63
# 60,00 GB (64.420.392.960 bytes)
# 7.832
# 125.821.080
# 1.997.160
# 255
# Disk #0, Partition #0
# 350,00 MB (367.001.600 bytes)
# 1.048.576 bytes
# Disk #0, Partition #1
# 59,16 GB (63.524.785.664 bytes)
# 368.050.176 bytes
# Disk #0, Partition #2
# 505,00 MB (529.530.880 bytes)
# 63.892.881.408 bytes

# PS C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils> $msinfo.MsInfo.Category.Category[1].Category[9].Category[0] | fl *


# name            : Drives
# Data            : {Data, Data, Data, Data...}
# LocalName       : Category
# NamespaceURI    : 
# Prefix          : 
# NodeType        : Element
# ParentNode      : Category
# OwnerDocument   : #document
# IsEmpty         : False
# Attributes      : {name}
# HasAttributes   : True
# SchemaInfo      : System.Xml.XmlName
# InnerXml        : <Data><Item><![CDATA[Drive]]></Item><Value><![CDATA[A:]]></Value></Data><Data><Item><![CDATA[Description]]></Item><Value><![CDATA[3 1/2 Inch Floppy Drive]]></Value></Data><Data 
#                   ><Item><![CDATA[]]></Item><Value><![CDATA[]]></Value></Data><Data><Item><![CDATA[Drive]]></Item><Value><![CDATA[C:]]></Value></Data><Data><Item><![CDATA[Description]]></Item><V 
#                   alue><![CDATA[Local Fixed Disk]]></Value></Data><Data><Item><![CDATA[Compressed]]></Item><Value><![CDATA[No]]></Value></Data><Data><Item><![CDATA[File
#                   System]]></Item><Value><![CDATA[NTFS]]></Value></Data><Data><Item><![CDATA[Size]]></Item><Value><![CDATA[59,16 GB (63.524.782.080
#                   bytes)]]></Value></Data><Data><Item><![CDATA[Free Space]]></Item><Value><![CDATA[28,59 GB (30.697.844.736 bytes)]]></Value></Data><Data><Item><![CDATA[Volume
#                   Name]]></Item><Value><![CDATA[]]></Value></Data><Data><Item><![CDATA[Volume Serial Number]]></Item><Value><![CDATA[364F1BFC]]></Value></Data><Data><Item><![CDATA[]]></Item><Val 
#                   ue><![CDATA[]]></Value></Data><Data><Item><![CDATA[Drive]]></Item><Value><![CDATA[D:]]></Value></Data><Data><Item><![CDATA[Description]]></Item><Value><![CDATA[Local Fixed      
#                   Disk]]></Value></Data><Data><Item><![CDATA[Compressed]]></Item><Value><![CDATA[No]]></Value></Data><Data><Item><![CDATA[File
#                   System]]></Item><Value><![CDATA[NTFS]]></Value></Data><Data><Item><![CDATA[Size]]></Item><Value><![CDATA[200,00 GB (214.745.153.536
#                   bytes)]]></Value></Data><Data><Item><![CDATA[Free Space]]></Item><Value><![CDATA[186,20 GB (199.934.672.896 bytes)]]></Value></Data><Data><Item><![CDATA[Volume
#                   Name]]></Item><Value><![CDATA[New Volume]]></Value></Data><Data><Item><![CDATA[Volume Serial Number]]></Item><Value><![CDATA[E6140FE4]]></Value></Data><Data><Item><![CDATA[]]>< 
#                   /Item><Value><![CDATA[]]></Value></Data><Data><Item><![CDATA[Drive]]></Item><Value><![CDATA[E:]]></Value></Data><Data><Item><![CDATA[Description]]></Item><Value><![CDATA[CD-ROM 
#                    Disc]]></Value></Data>
# InnerText       : DriveA:Description3 1/2 Inch Floppy DriveDriveC:DescriptionLocal Fixed DiskCompressedNoFile SystemNTFSSize59,16 GB (63.524.782.080 bytes)Free Space28,59 GB (30.697.844.736      
#                   bytes)Volume NameVolume Serial Number364F1BFCDriveD:DescriptionLocal Fixed DiskCompressedNoFile SystemNTFSSize200,00 GB (214.745.153.536 bytes)Free Space186,20 GB
#                   (199.934.672.896 bytes)Volume NameNew VolumeVolume Serial NumberE6140FE4DriveE:DescriptionCD-ROM Disc
# NextSibling     : Category
# PreviousSibling :
# Value           :
# ChildNodes      : {Data, Data, Data, Data...}
# FirstChild      : Data
# LastChild       : Data
# HasChildNodes   : True
# IsReadOnly      : False
# OuterXml        : <Category name="Drives"><Data><Item><![CDATA[Drive]]></Item><Value><![CDATA[A:]]></Value></Data><Data><Item><![CDATA[Description]]></Item><Value><![CDATA[3 1/2 Inch Floppy Driv 
#                   e]]></Value></Data><Data><Item><![CDATA[]]></Item><Value><![CDATA[]]></Value></Data><Data><Item><![CDATA[Drive]]></Item><Value><![CDATA[C:]]></Value></Data><Data><Item><![CDATA 
#                   [Description]]></Item><Value><![CDATA[Local Fixed Disk]]></Value></Data><Data><Item><![CDATA[Compressed]]></Item><Value><![CDATA[No]]></Value></Data><Data><Item><![CDATA[File   
#                   System]]></Item><Value><![CDATA[NTFS]]></Value></Data><Data><Item><![CDATA[Size]]></Item><Value><![CDATA[59,16 GB (63.524.782.080
#                   bytes)]]></Value></Data><Data><Item><![CDATA[Free Space]]></Item><Value><![CDATA[28,59 GB (30.697.844.736 bytes)]]></Value></Data><Data><Item><![CDATA[Volume
#                   Name]]></Item><Value><![CDATA[]]></Value></Data><Data><Item><![CDATA[Volume Serial Number]]></Item><Value><![CDATA[364F1BFC]]></Value></Data><Data><Item><![CDATA[]]></Item><Val 
#                   ue><![CDATA[]]></Value></Data><Data><Item><![CDATA[Drive]]></Item><Value><![CDATA[D:]]></Value></Data><Data><Item><![CDATA[Description]]></Item><Value><![CDATA[Local Fixed      
#                   Disk]]></Value></Data><Data><Item><![CDATA[Compressed]]></Item><Value><![CDATA[No]]></Value></Data><Data><Item><![CDATA[File
#                   System]]></Item><Value><![CDATA[NTFS]]></Value></Data><Data><Item><![CDATA[Size]]></Item><Value><![CDATA[200,00 GB (214.745.153.536
#                   bytes)]]></Value></Data><Data><Item><![CDATA[Free Space]]></Item><Value><![CDATA[186,20 GB (199.934.672.896 bytes)]]></Value></Data><Data><Item><![CDATA[Volume
#                   Name]]></Item><Value><![CDATA[New Volume]]></Value></Data><Data><Item><![CDATA[Volume Serial Number]]></Item><Value><![CDATA[E6140FE4]]></Value></Data><Data><Item><![CDATA[]]>< 
#                   /Item><Value><![CDATA[]]></Value></Data><Data><Item><![CDATA[Drive]]></Item><Value><![CDATA[E:]]></Value></Data><Data><Item><![CDATA[Description]]></Item><Value><![CDATA[CD-ROM 
#                    Disc]]></Value></Data></Category>
# BaseURI         :
# PreviousText    :

# PS C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils> $msinfo.MsInfo.Category.Category[1].Category[9].Category[0].Data | foreach {$_.Item}

# #cdata-section      
# --------------      
# Drive
# Description

# Drive
# Description
# Compressed
# File System
# Size
# Free Space
# Volume Name
# Volume Serial Number

# Drive
# Description
# Compressed
# File System
# Size
# Free Space
# Volume Name
# Volume Serial Number

# Drive
# Description


<#
.SYNOPSIS
    A short one-line action-based description, e.g. 'Tests if a function is valid'
.DESCRIPTION
    A longer description of the function, its purpose, common use cases, etc.
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
        [string]$msinfo32File = 'C:\Temp\06xxxxxx\02824089\05_07_2024\AFC-_02824089-SVIMGCAVW101.backup.lan-2024-05-07-11-42-23-279_1715075058\msinfo32.nfo'
    )
    
    begin {
        $Drives = @{}
        [xml]$msinfo = Get-Content $msinfo32File
    }
    
    process {
        $msinfo.MsInfo.Category.Category[1].Category[9].Category[0].Data | 
ForEach-Object {($_.Item.OuterXml.Replace('<Item><![CDATA[','').Replace(']]></Item>',''))}

$msinfo.MsInfo.Category.Category[1].Category[9].Category[0].Data | 
ForEach-Object {$_.Value.OuterXml.Replace('<Value><![CDATA[','').Replace(']]></Value>','')}

$msinfo.MsInfo.Category.Category[1].Category[9].Category[0].Data | 
ForEach-Object {$Drives.Add($_.Item.OuterXml.Replace('<Item><![CDATA[','').Replace(']]></Item>',''),$_.Value.OuterXml.Replace('<Value><![CDATA[','').Replace(']]></Value>',''))}
    }
    
    end {
        Write-Output $Drives
    }
}
Get-MSInfo





