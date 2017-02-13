<#	
	.NOTES
	===========================================================================
	 Posted by : 	https://learn-powershell.net/2012/12/02/powershell-and-wpf-listbox/
	 Created on:   	2/9/2017 11:43 PM
	 Created by:   	CailleauThierry
	 Organization: 	Private
	 Filename:     	Powershell_and_WPF_Listbox.ps1
	===========================================================================
	.DESCRIPTION
		Powershell_and_WPF_Listbox.ps1
#>

#Build the GUI
[xml]$xaml = @'
<Window 
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    x:Name="Window" Title="Initial Window" WindowStartupLocation = "CenterScreen" ResizeMode="NoResize"
    Width = "313" Height = "425" ShowInTaskbar = "True" Background = "lightgray"> 
    <StackPanel >
        <TextBox x:Name="readonlyTextBox" IsReadOnly="True" TextWrapping="Wrap">
            Type something into the text box below and click Add to update the listbox.
        </TextBox>
        <TextBox x:Name="inputTextBox" />
        <Button x:Name="addButton" Content="Add"/>
        <Button x:Name="removeButton" Content="Remove Selected Item/s"/>
        <ListBox x:Name="listbox" MinHeight = "50" AllowDrop="True" SelectionMode="Extended"/>
    </StackPanel>
</Window>
'@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$Window = [Windows.Markup.XamlReader]::Load($reader)

#Connect to Controls
$inputTextBox = $Window.FindName('inputTextBox')
$addButton = $Window.FindName('addButton')
$listbox = $Window.FindName('listbox')
$removeButton = $Window.FindName('removeButton')

#Events
$addButton.Add_Click({
		If ((-NOT [string]::IsNullOrEmpty($inputTextBox.text))) {
			$listbox.Items.Add($inputTextBox.text)
			$inputTextBox.Clear()
		}
	})
$removeButton.Add_Click({
		While ($listbox.SelectedItems.count -gt 0) {
			$listbox.Items.RemoveAt($listbox.SelectedIndex)
		}
	})
$listbox.Add_Drop({
		(Get-Content $_.Data.GetFileDropList()) | ForEach-Object {
			$listbox.Items.Add($_)
		}
	})

$Window.ShowDialog() | Out-Null