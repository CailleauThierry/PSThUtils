
# Define the folders you want to scan
$paths = @(
    "C:\Program Files\Carbonite Server Backup",
    "C:\inetpub"
)


# Output file
$outputFile = "C:\Temp\FileVersions.csv"

$result = foreach ($path in $paths) {
    Get-ChildItem -Path $path -Recurse -Include *.exe, *.dll -File -ErrorAction SilentlyContinue |
    ForEach-Object {
        try {
            $version = [System.Diagnostics.FileVersionInfo]::GetVersionInfo($_.FullName)

            if ($version.FileVersion) {
                [PSCustomObject]@{
                    Path        = $_.FullName
                    FileName    = $_.Name
                    Version     = $version.FileVersion
                    Product     = $version.ProductName
                }
            }
        }
        catch {
            # Skip unreadable files
        }
    }
}

# Export results to CSV
$result | Where-Object { $_.Version -ne $null } | Tee-Object -Variable displaytest | Export-Csv -Path $outputFile -NoTypeInformation 

# Optional: display results in console
$displaytest | Format-Table FileName,Version,Product -AutoSize
