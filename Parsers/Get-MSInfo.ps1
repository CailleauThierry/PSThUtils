function Get-MSInfo{
    <#
    .SYNOPSIS
        Get-MSinfo.ps1 implements the function Get-MSInfo which parse msinfo32.nfo files
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
    begin {
        # Have the $_ in this beginning section does not work. Let's not use that section for that!
    <#
    PS C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils> $msinfo                                                              
    xml           MsInfo
    ---           ------
    version="1.0" MsInfo
    PS C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils> $msinfo.MsInfo                                                       
    Metadata Category
    -------- --------
    Metadata Category
    PS C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils> $msinfo.MsInfo.Category                                              
    name           Data                        Category
    -------- --------
    System Summary {Data, Data, Data, Data...} {Hardware Resources, Components, Software Environment}
    PS C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils> $msinfo.MsInfo.Category.Data[0] | fl *


    Value           : Value
    Name            : Data
    LocalName       : Data
    NamespaceURI    :
    Prefix          :
    NodeType        : Element
    ParentNode      : Category
    OwnerDocument   : #document
    IsEmpty         : False
    Attributes      : {}
    HasAttributes   : False
    SchemaInfo      : System.Xml.XmlName
    InnerXml        : <Item><![CDATA[OS Name]]></Item><Value><![CDATA[Microsoft Windows Server 2019 Standard]]></Value>
    InnerText       : OS NameMicrosoft Windows Server 2019 Standard
    NextSibling     : Data
    PreviousSibling :
    ChildNodes      : {Item, Value}
    FirstChild      : Item
    LastChild       : Value
    HasChildNodes   : True
    IsReadOnly      : False
    OuterXml        : <Data><Item><![CDATA[OS Name]]></Item><Value><![CDATA[Microsoft Windows Server 2019 Standard]]></Value></Data>
    BaseURI         :
    PreviousText    :



    PS C:\Users\tcailleau\Documents\WindowsPowerShell\Scripts\PSThUtils> $msinfo.MsInfo.Category.Data.Count
    41
    #>
    }

    process {
        $Drives = @()
        $Drives = $null
        $myDrives  = @()
        $myDrives = $null
        $msinfo32File =  $_.FullName
        [xml]$msinfo = Get-Content $_.FullName
        #Scanning $msinfo to find what "Item" and "Value" is on the msinfo32.nfo's Language
        $MyItem = $msinfo.MsInfo.Category.Data[0].OuterXml | select-String -AllMatches -Pattern '<Data><(\w*)>' | ForEach-Object -MemberName Matches | ForEach-Object {$_.Groups[1].Value}
        $MyValue = $msinfo.MsInfo.Category.Data[0].OuterXml | select-String -AllMatches -Pattern "<Data>.*$MyItem><(\w*)" | ForEach-Object -MemberName Matches | ForEach-Object {$_.Groups[1].Value}
        $MyItemLeft = '<' + "$MyItem" + '><![CDATA['
        $MyItemRight = ']]></' + "$MyItem" + '>'
        $MyValueLeft = '<' + "$MyValue" + '><![CDATA['
        $MyValueRight = ']]></' + "$MyValue" + '>'
        #Getting main page info
        $msinfo.MsInfo.Category.Data |
            ForEach-Object {$Drives += ,@{($_.($MyItem).OuterXml.Replace($MyItemLeft,'').Replace($MyItemRight,''))=($_.($MyValue).OuterXml.Replace($MyValueLeft,'').Replace($MyValueRight,''))}}    
        # Getting Components > Storage > Drives info
        $msinfo.MsInfo.Category.Category[1].Category[9].Category[0].Data | 
            ForEach-Object {$Drives += ,@{($_.($MyItem).OuterXml.Replace($MyItemLeft,'').Replace($MyItemRight,''))=($_.($MyValue).OuterXml.Replace($MyValueLeft,'').Replace($MyValueRight,''))}}    

        $myDrives += $Drives | Out-String -Stream
        $myDrives | Out-File ($msinfo32File + ".log")
    }

    end {

        # This is also not a place that runs multiple times
    }
}

<# 
Confirmed that the 2 * .nfo bug is fixed since the last check-in

Idea for next version:

Flag the EVault Running Services 
#>