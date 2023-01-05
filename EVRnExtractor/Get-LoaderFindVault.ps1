<#	
	.NOTES
	===========================================================================
	 Created with:  VSCode	Version: 1.74.2
	 Created on:   	01_05_2023_18:04
	 Created by:   	Administrator
	 Organization: 	Private
	 Filename:     	Get-LoaderFindVault.ps1
	===========================================================================
	.DESCRIPTION
		This is a first attempt to use EVR 2.8's SOAP API
#>

<# from http://10.9.170.226/Loader/Loader.asmx?op=FindVault:


SOAP 1.2

The following is a sample SOAP 1.2 request and response. The placeholders shown need to be replaced with actual values.

POST /Loader/Loader.asmx HTTP/1.1
Host: 10.9.170.226
Content-Type: application/soap+xml; charset=utf-8
Content-Length: length

<?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
    <FindVault xmlns="http://tempuri.org/">
      <vaults>
        <guid>guid</guid>
        <guid>guid</guid>
      </vaults>
    </FindVault>
  </soap12:Body>
</soap12:Envelope>

HTTP/1.1 200 OK
Content-Type: application/soap+xml; charset=utf-8
Content-Length: length

<?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
    <FindVaultResponse xmlns="http://tempuri.org/">
      <FindVaultResult>int</FindVaultResult>
      <VaultData>
        <ID>guid</ID>
        <Name>string</Name>
        <Description>string</Description>
        <Timezone>short</Timezone>
      </VaultData>
    </FindVaultResponse>
  </soap12:Body>
</soap12:Envelope>


And from: C:\Director\logs\WebExtract-63B4B384-1EDC-08F0.LOG:

04-Jan-2023 00:00:20.557 +01:00 [2288] VVLT-I-0177 Copyright 2022 Carbonite, Inc.
04-Jan-2023 00:00:20.573 +01:00 [2288] VVLT-I-0219 Carbonite Server Backup Director Version 8.62.0152 (64-bit) Apr 29 2022 15:56:23
04-Jan-2023 00:00:20.573 +01:00 [2288] VVLT-I-0001 Vault: TCD1
04-Jan-2023 00:00:20.573 +01:00 [2288] VVLT-I-0001 Process: 7900 (C:\Director\prog\SynchWeb.exe), thread = 2288
04-Jan-2023 00:00:20.573 +01:00 [2288] VVLT-I-0001 Read data: True
04-Jan-2023 00:00:20.573 +01:00 [2288] VVLT-I-0001 Send data: True
04-Jan-2023 00:00:20.573 +01:00 [2288] VVLT-I-0001 
04-Jan-2023 00:00:20.604 +01:00 [2288] VVLT-I-0001 Web service url: http://tcloader/Loader/Loader.asmx
04-Jan-2023 00:00:20.604 +01:00 [2288] VVLT-I-0001 Web service timeout: 100000 ms
04-Jan-2023 00:00:20.604 +01:00 [2288] VVLT-I-0001 User: <not set>
04-Jan-2023 00:00:20.604 +01:00 [2288] VVLT-I-0001 Port: 80
04-Jan-2023 00:00:20.604 +01:00 [2288] VVLT-I-0001 Data path: C:\Director\Data
04-Jan-2023 00:00:20.604 +01:00 [2288] VVLT-I-0001 Block count in a service call: 100
04-Jan-2023 00:00:20.604 +01:00 [2288] VVLT-I-0001 Call web service synchronous.
04-Jan-2023 00:00:20.604 +01:00 [2288] VVLT-I-0001 Logging: NONE
04-Jan-2023 00:00:20.604 +01:00 [2288] VVLT-I-0001 Keep snapshot (days): 30
04-Jan-2023 00:00:20.604 +01:00 [2288] VVLT-I-0001 Use csv snapshot format: True
04-Jan-2023 00:00:20.620 +01:00 [2288] VVLT-I-0001 
04-Jan-2023 00:00:20.620 +01:00 [2288] VVLT-I-0001 SynchWeb executing on SQL+worker node.
04-Jan-2023 00:00:21.417 +01:00 [2288] VVLT-I-0001 Retrieving vault id to use ...
04-Jan-2023 00:00:22.767 +01:00 [2288] ACTV-W-0002 WARNING: The activation expiry date will be exceeded in 2 days.
04-Jan-2023 00:00:22.767 +01:00 [2288] ACTV-W-0002 Please re-activate the Director within 2 days.
04-Jan-2023 00:00:22.923 +01:00 [2288] VVLT-I-0001 List of replicating vaults:
04-Jan-2023 00:00:22.923 +01:00 [2288] VVLT-I-0001 ccaf072d-2df8-46f7-aa55-0afb21ad49a8
04-Jan-2023 00:00:22.923 +01:00 [2288] VVLT-I-0001 24d02310-ba6f-41f0-ad69-75f9dd9acae2


#>

$Body = @"
<?xml version="1.0" encoding="utf-8"?>
<soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  <soap12:Body>
    <FindVault xmlns="http://tempuri.org/">
      <vaults>
        <guid>ccaf072d-2df8-46f7-aa55-0afb21ad49a8</guid>
        <guid>24d02310-ba6f-41f0-ad69-75f9dd9acae2</guid>
      </vaults>
    </FindVault>
  </soap12:Body>
</soap12:Envelope>
"@

Invoke-WebRequest -Uri 'http://10.9.170.226/Loader/Loader.asmx?op=FindVault' -Method POST -Body $Body -ContentType 'application/soap+xml; charset=utf-8' 

<# Result: 

PS C:\Users\Administrator\Documents\WindowsPowerShell\Scripts\PSThUtils> . 'c:\Users\Administrator\Documents\WindowsPowerShell\Scripts\PSThUtils\EVRnExtractor\Get-LoaderFindVault.ps1'


StatusCode        : 200
StatusDescription : OK
Content           : <?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    xmlns:xsd="http://www.w3.org/2001/XMLSch...
RawContent        : HTTP/1.1 200 OK
                    Content-Length: 535
                    Cache-Control: private, max-age=0
                    Content-Type: application/soap+xml; charset=utf-8
                    Date: Thu, 05 Jan 2023 16:45:44 GMT
                    Server: Microsoft-IIS/10.0


                    X-AspNet-Ve...
Forms             : {}
Headers           : {[Content-Length, 535], [Cache-Control, private, max-age=0], [Content-Type, application/soap+xml; charset=utf-8], [Date, Thu, 05 Jan 2023 16:45:44 GMT]...}
Images            : {}
InputFields       : {}
Links             : {}
ParsedHtml        : System.__ComObject
RawContentLength  : 535



PS C:\Users\Administrator\Documents\WindowsPowerShell\Scripts\PSThUtils>
Do you want to run Update-Help?
The Update-Help cmdlet downloads the most current Help files for Windows PowerShell modules, and installs them on your computer. For more information about the Update-Help cmdlet,
see https:/go.microsoft.com/fwlink/?LinkId=210614.
[Y] Yes  [N] No  [S] Suspend  [?] Help (default is "Y"):
#>

Invoke-WebRequest -Uri 'http://10.9.170.226/Loader/Loader.asmx?op=FindVault' -Method POST -Body $Body -ContentType 'application/soap+xml; charset=utf-8' | Select-Object RawContent 

<# 
Result:
RawContent : HTTP/1.1 200 OK
             Content-Length: 535
             Cache-Control: private, max-age=0
             Content-Type: application/soap+xml; charset=utf-8
             Date: Thu, 05 Jan 2023 16:58:37 GMT
             Server: Microsoft-IIS/10.0
             X-AspNet-Version: 4.0.30319
             X-Powered-By: ASP.NET

             <?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><FindVaultResponse
             xmlns="http://tempuri.org/"><FindVaultResult>0</FindVaultResult><VaultData><ID>24d02310-ba6f-41f0-ad69-75f9dd9acae2</ID><Name>TCD1</Name><Description>VMware-42 15 d4
             c2 c7 7f 79 7a-97 f8 1c bf ea 84 33 1f</Description><Timezone>0</Timezone></VaultData></FindVaultResponse></soap:Body></soap:Envelope>
#>

Invoke-WebRequest -Uri 'http://10.9.170.226/Loader/Loader.asmx?op=FindVault' -Method POST -Body $Body -ContentType 'application/soap+xml; charset=utf-8' | Select-Object RawContent | Out-String -Width 4096


<# Result: 
RawContent : HTTP/1.1 200 OK
             Content-Length: 535
             Cache-Control: private, max-age=0
             Content-Type: application/soap+xml; charset=utf-8
             Date: Thu, 05 Jan 2023 17:01:30 GMT
             Server: Microsoft-IIS/10.0
             X-AspNet-Version: 4.0.30319
             X-Powered-By: ASP.NET

             <?xml version="1.0" encoding="utf-8"?><soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
             xmlns:xsd="http://www.w3.org/2001/XMLSchema"><soap:Body><FindVaultResponse
             xmlns="http://tempuri.org/"><FindVaultResult>0</FindVaultResult><VaultData><ID>24d02310-ba6f-41f0-ad69-75f9dd9acae2</ID><Name>TCD1</Name><Description>VMware-42 15 d4
             c2 c7 7f 79 7a-97 f8 1c bf ea 84 33 1f</Description><Timezone>0</Timezone></VaultData></FindVaultResponse></soap:Body></soap:Envelope>


RawContent




----------




HTTP/1.1 200 OK...









PS C:\Users\Administrator\Documents\WindowsPowerShell\Scripts\PSThUtils>
#>