#beginning of#################################################################
##
## Get-Clipboard
##
## From Windows PowerShell Cookbook (O'Reilly)
## by Lee Holmes (http://www.leeholmes.com/guide)
##
##############################################################################
function Get-Clipboard([switch] $Lines) {
	if($Lines) {
		$cmd = {
			Add-Type -Assembly PresentationCore
			[System.Windows.Clipboard]::GetText() -replace "`r", '' -split "`n"
		}
	} else {
		$cmd = {
			Add-Type -Assembly PresentationCore
			[System.Windows.Clipboard]::GetText()
		}
	}
	if([threading.thread]::CurrentThread.GetApartmentState() -eq 'MTA') {
		& powershell -Sta -Command $cmd
	} else {
		& $cmd
	}
}


#end of#######################################################################
##
## Get-Clipboard
##
## From Windows PowerShell Cookbook (O'Reilly)
## by Lee Holmes (http://www.leeholmes.com/guide)
##
##############################################################################

# $log1 = Get-Clipboard -Lines