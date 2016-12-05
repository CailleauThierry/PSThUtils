# Office
Microsoft Office related utilities

## About TimedTask.ps1
### TimedTask.ps1 Installation
You can download the Time Tracking script by downloading the full repository from:

https://github.com/CailleauThierry/PSThUtils > "Download ZIP"

All you need are the following 2 files + WMF 5.0 installed (PowerShell 5) available from:

- https://www.microsoft.com/en-us/download/details.aspx?id=50395
- TimedTask.bat
- TimedTask.ps1

You can set your execution policies to Unrestricted or Bypass:

1.	In a PowerShell prompt launch with "Run As Administrator" priviledges
2.	Set-ExecutionPolicy -ExecutionPolicy Bypass  # say yes

The auto-generated .csv file will be in the $profile directory (just type “$profile” in PowerShell to find out where that is)

To launch the script, launch your edited version of "TimedTask.bat".

You can launch the script from anywhere as long as you adjust the path in "TimedTask.bat".

### TimedTask.ps1 User Guide

1. Double-clicking "TimedTask.bat"
2. A PowerShell console will open and then a Windows Form Pop-up will appear > this is what we will use
3. Enter the text in the form and do either:
  * OK > this will close the form and add that text to the .csv file (it will also create that file the first time)
  * Leave the Form open and only click "OK" when the task is completed. This will update the "Duration" column of the .csv file with that time-span

- Note: Do not have Excel open that .csv if you want the script to be able to add another entry to it. Excel "locks" access to that .csv file...
