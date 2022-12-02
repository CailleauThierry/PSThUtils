KEYS=aeiounc

Coordmode,ToolTip,Screen
a:=["E0","E1","E2","E3","E4","61"]
CaPA:=["C0","C1","C2","C3","C4","41"]
e:=["E8","E9","EA","65","EB","65"]
CaPE:=["C8","C9","CA","45","CB","45"]
i:=["EC","ED","EE","69","EF","69"]
CAPI:=["CC","CD","CE","49","CF","49"]
o:=["F2","F3","F4","F5","F6","6F"]
CAPO:=["D2","D3","D4","D5","D6","4F"]
u:=["F9","FA","FB","75","FC","75"]
CAPu:=["D9","DA","DB","55","DC","55"]
n:=["6E","6E","6E","F1","6E","6E"]
capn:=["4E","4E","4E","D1","4E","4E"]
c:=["63","63","63","63","63","E7"]
capc:=["43","43","43","43","43","C7"]
RETURN
ACCENT:
key:=IF GETKEYSTATE("CAPSLOCK","T") ? "+" a_thishotkey : a_thishotkey
KEY:=IF INSTR(KEY,"+") ? "CaP" REGEXREPLACE(KEY,"\+") : KEY
gosub,off
send % CHR("0X" %KEY%[CURRENT])
tooltip,
return
f9::
reload
return
on:
loop,parse,keys
{
 HOTKEY,%a_loopfield%,ACCENT,ON
 hotkey,+%a_loopfield%,ACCENT,ON
}
return
off:
loop,parse,keys
{
 HOTKEY,%a_loopfield%,ACCENT,off
 hotkey,+%a_loopfield%,ACCENT,off
}
return
#'::
accent("acute")
#`::
accent("grave")
#6::
accent("circumflex")
#;::
accent("umlaut")
#,::
accent("cedilla")
#+`::
accent("tilda")
accent(accent){
 global
 TYPE:=["GRAVE","ACUTE","CIRCUMFLEX","TILDA","UMLAUT","CEDILLA"]
 FOR index,t IN TYPE
 IF t=%accent%
 CURRENTtype:=t,current:=a_index
 tooltip,%currenttype%,0,0
 gosub,on
 exit
}


#F3::Send, \\clc-files.carboniteinc.com\DevKits\Production
#F4::Send, http://downloadserver.evault.com/download/DownloadFile?fp=software/current/8.83/client/Agent-Linux-x64-8.83.8124.tar.gz
#F5::Send, %A_Mon%_%A_MDay%_%A_Year%_%A_Hour%:%A_Min%
#F6::Send, %A_Mon%_%A_MDay%_%A_Year% ; or %A_Now% i.e. 20141210100115 Short date REsult: 02_10_2022
#F7::Send, %A_dddd% %A_MMMM% %A_dd%, %A_YYYY% ; or %A_Now% i.e. 20141210100115 Result: Thursday February 10, 2022
#F8::Send, \\clc-files.carboniteinc.com\Support\PR\
#F9::Send, \\clc-ftp01.carboniteinc.com\EVaultSupport\FTP_Root  
#F10::Send, \\wak-ftp01.carboniteinc.com\Heroku\case_attachments\
#F11::
Send, Case ID: ?
return
#F12::Send, Using late lunch break to pickup kid at school
#T::Run, "%HOMEPATH%\Documents\WindowsPowerShell\Scripts\PSThUtils\Office\TimedTask.bat" 
#Z::Run, "%HOMEPATH%\Documents\WindowsPowerShell\Scripts\PSThUtils\Parsers\Get-ForensicFromLocation.bat"
#Y::Run, "%HOMEPATH%\Documents\WindowsPowerShell\Scripts\PSThUtils\Office\Get-SysEventStartStop.bat"

#A::
Send, Notes taken on     : %A_Mon%_%A_MDay%_%A_Year%_%A_Hour%:%A_Min% (CET) by Thierry Cailleau {Enter}
Send, Working with         :  (a.k.a. JL)
Send, {Enter}
Send, Vault Name or IP  : 
Send, {Enter}
Send, Vault Version        : 
Send, {Enter}
Send, Agent Host Name: 
Send, {Enter}
Send, Agent OS             : 
Send, {Enter}
Send, Agent Version      : 
Send, {Enter}
Send, Portal Version      : 
Send, {Enter}
Send, Task Name          : 
Send, {Enter}
Send, < 3rd Party App> Version:
Send, {Enter}
Send, {Enter}
Send, Action:
Send, {Enter}
Send,  --------------------------------------------
Send, {Enter}
Send, {Enter}
Send, Next Steps:
Send, {Enter}
Send,  --------------------------------------------
Send, {Enter}
Send, {Enter}
return

#Q::
MST := A_Hour - 8
Send, Agent Name: Thierry Cailleau{Enter}
Send, Approximate time of the issue: %A_Hour%h%A_Min%m%A_sec% (CET) i.e. %MST%h%A_Min%m%A_sec% (MST){Enter}
Send, How long did the issue last: 20 minutes
Send, {Enter}
Send, Laptop model: Latitude E5570{Enter}
Send, Home network details (wired/wireless, router model, ISP): Home LAN Tweak.nl (e-fiber)
Send, {Enter}
Send, City/location the person is working from: The Netherlands
Send, {Enter}
Send, Issue: The customer could not hear me
Send, {Enter}
return
#"::
Send {ASC 0148}
return



#E::
Send, Carbonite CSB temporary support ticket
Send {ASC 0032} ; space
Send {ASC 00035} ; #
Send {ASC 0032} ; space
Send, {Enter}
Send, Dear ,{Enter}
Send, {Enter}
Send, We are using a new ticketing platform...
Send, {Enter}
Send, Your old ticket number was 06668651, the new one is 00280909 
Send, {Enter}
Send, {Enter}
Send, Best regards,{Enter}
Send, {Enter}
Send, Thierry Cailleau{Enter}
Send, Senior Service Specialist{Enter}
Send, EMEA
Send {ASC 0032} ; space
Send {ASC 0043} ; +
Send, 44 (0)800-014-8966{Enter}
Send, Belgium
Send {ASC 0032} ; space
Send {ASC 0043} ; +
Send, 32 78 48 01 77{Enter}
Send, USA 1-866-855-9555{Enter}
Send, AUSTRALIA 1800-751-697{Enter}
Send, SINGAPORE 800-852-3977{Enter}
Send, www.evault.com{Enter}
Send, 4225 Lake Park Blvd
Send {ASC 0032} ; space
Send {ASC 0149} ; �
Send {ASC 0032} ; space
Send, Suite 400
Send {ASC 0032} ; space
Send {ASC 0149} ; �
Send, {Enter}
Send, Salt Lake City, Utah 84120
Send {ASC 0032} ; space
Send {ASC 0149} ; �
Send {ASC 0032} ; space
Send, USA{Enter}
Send, {Enter}
Send, https://www.carbonite.com/customer-support/ 
Send, {Enter}
Send, {Enter}
Send, Carbonite Backup for Microsoft 365 - Office365Backup@Carbonite.com 
Send, {Enter}
Send, {Enter}
Send, Carbonite Server (formerly EVault) - support@evault.com 
Send, {Enter}
Send, {Enter}
Send, Carbonite Endpoint - endpointsupport@carbonite.com 
Send, {Enter}
Send, {Enter}
Send, Carbonite Availability (formerly DoubleTake) - support@doubletake.com 
Send, {Enter}
Send, {Enter}
return