<#	
	.NOTES
	===========================================================================
	 Posted by : 	https://social.technet.microsoft.com/Forums/windowsserver/en-US/575f6345-19cd-46da-8b82-bd1921370d96/powershell-combobox?forum=winserverpowershell
	 Created on:   	2/9/2017 11:36 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	FormTextButtondropDownExample.ps1
	===========================================================================
	.DESCRIPTION
		gets out of value from Combobox function to label or textbox.
#>

[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

$Form1 = New-Object System.Windows.Forms.Form
$Form1.ClientSize = New-Object System.Drawing.Size(407, 390)
$form1.topmost = $true


$computerNames = @(1, 2, 3)
$comboBox1 = New-Object System.Windows.Forms.ComboBox
$comboBox1.Location = New-Object System.Drawing.Point(25, 55)
$comboBox1.Size = New-Object System.Drawing.Size(350, 310)
foreach ($computer in $computerNames) {
	$comboBox1.Items.add($computer)
}
$Form1.Controls.Add($comboBox1)

$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Point(25, 20)
$Button.Size = New-Object System.Drawing.Size(98, 23)
$Button.Text = "Output"
$Button.add_Click({
		$label.Text = $comboBox1.SelectedItem.ToString()
	})
$Form1.Controls.Add($Button)

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(70, 90)
$label.Size = New-Object System.Drawing.Size(98, 23)
$label.Text = ""
$Form1.Controls.Add($label)

[void]$form1.showdialog()