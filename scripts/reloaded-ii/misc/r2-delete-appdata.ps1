$appdataRoaming = "$env:APPDATA\Reloaded-Mod-Loader-II"
$appdataLocal = "$env:LOCALAPPDATA\Reloaded-Mod-Loader-II"

Write-Host "Will delete the following directories:" -ForegroundColor Cyan
Write-Host "$appdataRoaming"
Write-Host "$appdataLocal"

if ((Test-Path -Path $appdataRoaming -PathType Container) -or (Test-Path -Path $appdataLocal -PathType Container)) {
    Write-Host "`nNote: This script will close Reloaded-II to prevent any potential data loss." -ForegroundColor Yellow
    $confirm = Read-Host -Prompt "Are you sure you want to delete the Reloaded-II directories in AppData folders? (Y)"

    if ($confirm -eq 'YES' -or $confirm -eq 'Y' -or $confirm -eq '') {
        Write-Host "`nAttempting to close the app..."
        Stop-Process -Name 'reloaded-ii' -Force -Verbose -ErrorAction SilentlyContinue

        Remove-Item -Path $appdataRoaming, $appdataLocal -Force -Recurse -ErrorAction SilentlyContinue
        Write-Host "`nThe Reloaded-II directories have been deleted." -ForegroundColor Green
    }
    else {
        Write-Host "`nPrompt cancelled." -ForegroundColor Yellow
    }
}
else {
    Write-Host "`nError: The Reloaded-II directories does not exist." -ForegroundColor Red
}
