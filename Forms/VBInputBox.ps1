<#	
	.NOTES
	===========================================================================
	 Posted by : 	https://gallery.technet.microsoft.com/scriptcenter/4b2eedbb-d1b8-43e1-b042-1b38e36d3ab9
	 Created on:   	11/12/2016 4:28 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	VBInputBox.ps1
	===========================================================================
	.DESCRIPTION
		A description of the file.
	.NOTES
		Tested with PS V5 (64-bits) and PS V2 (64-bits)
#>
# Example to show an InputBox opening another InputBox on button click, opening the first one 
# and display entered text 


[void][System.Reflection.Assembly]::LoadWithPartialName(
	"System.Windows.Forms")
[void][System.Reflection.Assembly]::LoadWithPartialName(
	"Microsoft.VisualBasic")

$Form = New-Object System.Windows.Forms.Form
$Button = New-Object System.Windows.Forms.Button
$TextBox = New-Object System.Windows.Forms.TextBox

$Form.Text = "Visual Basic InputBox Example"
$Form.StartPosition =
[System.Windows.Forms.FormStartPosition]::CenterScreen

$Button.Text = "Show Input Box"
$Button.Top = 20
$Button.Left = 90
$Button.Width = 100

$TextBox.Text = "Old value"
$TextBox.Top = 60
$TextBox.Left = 90

$Form.Controls.Add($Button)
$Form.Controls.Add($TextBox)

$Button_Click =
{
	$EnteredText =
	[Microsoft.VisualBasic.Interaction]::InputBox(
		"Prompt", "Title", "Default value",
		$Form.Left + 50, $Form.Top + 50)
	
	# If the InputBox Cancel button is clicked 
	# InputBox returns an empty string 
	# so don't change the TextBox value 
	
	if ($EnteredText.Length -gt 0)
	{
		$TextBox.Text = $EnteredText
	}
}

$Button.Add_Click($Button_Click)

$Form.ShowDialog()