$rootApps = "$PSScriptRoot\Apps"
$rootUser = "$PSScriptRoot\User"
$rootMods = "$PSScriptRoot\Mods"
$originalMods = "$PSScriptRoot\Mods.orig"

if (!(Test-Path $originalMods)) {
    Write-Host "Test Mode is already disabled. Exiting." -ForegroundColor Red
    exit
}

Write-Host "Note: This script will close Reloaded-II to prevent any potential data loss." -ForegroundColor Yellow
$confirm = Read-Host -Prompt "Are you sure you want to disable Test Mode? (Y)"

if ($confirm -eq 'YES' -or $confirm -eq 'Y' -or $confirm -eq '') {
    Write-Host "`nAttempting to close the app..."
    Stop-Process -Name 'reloaded-ii' -Force -Verbose -ErrorAction SilentlyContinue
    Start-Sleep 1

    Remove-Item -Path $rootApps, $rootUser, $rootMods -Force -Recurse -ErrorAction SilentlyContinue
    Rename-Item -Path $originalMods -NewName Mods

    Write-Host "`nTest Mode has been disabled. Don't forget to set any profile as active." -ForegroundColor Green
}
else {
    Write-Host "`nPrompt cancelled." -ForegroundColor Yellow
}
