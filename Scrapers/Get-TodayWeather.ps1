<#
	.NOTES
	===========================================================================
	 Posted by : 	Microsoft Geek <http://microsoftgeek.com/?p=2550>
	 Created on:   	02_18_2021 9:57 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:      Get-TodayWeather.ps1
	===========================================================================
	.DESCRIPTION
How to Get Weather Forecast In PowerShell
July 31, 2018Microsoft Geek
We will use an open source web service wttr.in to fetch the weather forecast. 
Wttr.in can be used not only to check the weather, but also for some other purposes. 
For example, you can see the current Moon phase. 
In PowerShell, there is a special alias "curl" for the built-in cmdlet Invoke-RestMethod, which can retrieve the URL contents from the PowerShell console.
To get the weather forecast in PowerShell, you can use the following commands.
To get the current weather in PowerShell, type or copy-paste the following command:
(curl http://wttr.in/?Q0 -UserAgent "curl" ).Content
You can specify the desired location as follows:
(curl http://wttr.in/NewYork -UserAgent "curl" ).Content
The output will be as follows:
You can specify the country where you live when required. The syntax is as follows:
(curl http://wttr.in/"Madrid,Spain" -UserAgent "curl" ).Content
Double quotes are important to ensure that the location will be passed to the service, 
otherwise you will get an error in PowerShell.
The service supports a number of options.
Alternatively, you can use this command in your terminal:
(curl http://wttr.in/:help -UserAgent "curl" ).Content
Here are some useful options.
(curl wttr.in/New-York?n  -UserAgent "curl" ).Content
This will display the short version of the forecast which includes only Noon and Night.
(curl wttr.in/New-York?0 -UserAgent "curl" ).Content
This will show only the current weather in the specified location.
It is worth mentioning that the wttr.in service can show the forecast right in your web browser. 
Point your browser to the same location you use in PowerShell.
If you add ".png" to the location, the service will return a PNG image. You can embed it in your web page.
For example, open this link: http://wttr.in/New-York.png

#>

(Invoke-WebRequest http://wttr.in/Oss?0 -UserAgent "curl" ).Content
(Invoke-WebRequest http://wttr.in/Moon -UserAgent "curl").Content

