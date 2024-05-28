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
        $msinfo32File =  $_.FullName
        [xml]$msinfo = Get-Content $_.FullName

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