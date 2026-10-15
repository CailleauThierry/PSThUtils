#Requires -Version 5.1

<#
.SYNOPSIS
    Resets File Explorer folder views to favor:
      - Sort by Name
      - Ascending
      - Group by None
      - General Items folder type

    Intended for Windows 11.
#>

$ErrorActionPreference = 'Stop'

Write-Host "Configuring File Explorer folder views..." -ForegroundColor Cyan

# ------------------------------------------------------------
# Registry locations used by Explorer for saved folder views
# ------------------------------------------------------------

$ShellPath1 = 'HKCU:\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell'
$ShellPath2 = 'HKCU:\Software\Microsoft\Windows\Shell'

# ------------------------------------------------------------
# Stop Explorer before changing its cached folder views
# ------------------------------------------------------------

Write-Host "Stopping File Explorer..." -ForegroundColor Yellow

Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue

Start-Sleep -Seconds 1


# ------------------------------------------------------------
# Reset existing per-folder views
# ------------------------------------------------------------

$PathsToRemove = @(
    "$ShellPath1\Bags",
    "$ShellPath1\BagMRU",
    "$ShellPath2\Bags",
    "$ShellPath2\BagMRU"
)

foreach ($Path in $PathsToRemove) {

    if (Test-Path $Path) {
        Write-Host "Resetting: $Path"
        Remove-Item -Path $Path -Recurse -Force
    }
}


# ------------------------------------------------------------
# Create default AllFolders configuration
# ------------------------------------------------------------

$AllFolders = "$ShellPath1\Bags\AllFolders"
$Shell      = "$AllFolders\Shell"

New-Item -Path $Shell -Force | Out-Null


# ------------------------------------------------------------
# Disable automatic folder-type detection
#
# This prevents Explorer from automatically switching folders
# to Pictures, Music, Videos, Documents, etc.
# ------------------------------------------------------------

New-ItemProperty `
    -Path $Shell `
    -Name 'FolderType' `
    -PropertyType String `
    -Value 'NotSpecified' `
    -Force | Out-Null


# ------------------------------------------------------------
# Restart Explorer
# ------------------------------------------------------------

Write-Host "Restarting File Explorer..." -ForegroundColor Yellow

Start-Process explorer.exe

Write-Host ""
Write-Host "Explorer folder views have been reset." -ForegroundColor Green
Write-Host ""
Write-Host "Target configuration:"
Write-Host "  Sort by  : Name"
Write-Host "  Direction: Ascending"
Write-Host "  Group by : None"
Write-Host "  Template : General Items"