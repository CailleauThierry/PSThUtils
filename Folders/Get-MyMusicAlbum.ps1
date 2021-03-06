$NumberOf1stLevelDirectories = (Get-ChildItem $env:USERPROFILE\Music\ -Directory).Name.Length
Get-ChildItem $env:USERPROFILE\Music\ -Directory -Recurse | 
    Select-Object {$_.FullName.Replace("$env:USERPROFILE\Music\",'')} -Skip $NumberOf1stLevelDirectories |
        Format-Table -HideTableHeaders | 
            Out-File $env:USERPROFILE\Music\List_Of_Albums.csv -Force
Import-Csv $env:USERPROFILE\Music\List_Of_Albums.csv -Header Artist,Album,Volume -Delimiter '\' | Format-Table * -AutoSize  | Out-File $env:USERPROFILE\Music\List_Of_Albums.txt -Force
notepad $env:USERPROFILE\Music\List_Of_Albums.txt