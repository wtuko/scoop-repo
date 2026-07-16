$targetDirectory = "$PSScriptRoot\_Profiles"

Write-Host "Available profiles:" -ForegroundColor Cyan
Get-ChildItem -Path $targetDirectory -Directory | Select-Object -ExpandProperty Name

$folderName = Read-Host -Prompt "`nEnter the name of the profile to delete"

if ([string]::IsNullOrWhiteSpace($folderName)) {
    Write-Host "`nError: You did not enter a profile name. Please try again." -ForegroundColor Red
    exit
}

$fullPath = Join-Path -Path $targetDirectory -ChildPath $folderName

if (Test-Path -Path $fullPath -PathType Container) {
    Write-Host "`nNote: This script will close Reloaded-II to prevent any potential data loss." -ForegroundColor Yellow
    $confirm = Read-Host -Prompt "Are you sure you want to delete '$folderName'? (Y)"

    if ($confirm -eq 'YES' -or $confirm -eq 'Y' -or $confirm -eq '') {
        Write-Host "`nAttempting to close the app..."
        Stop-Process -Name 'reloaded-ii' -Force -Verbose -ErrorAction SilentlyContinue
        Start-Sleep 1

        $rootApps = "$PSScriptRoot\Apps"
        $rootUser = "$PSScriptRoot\User"

        Remove-Item -Path $fullPath -Force -Recurse
        Write-Host "`nProfile '$folderName' has been deleted." -ForegroundColor Green

        try {
            Write-Host "`nAttempting to delete inaccessible directories..."
            Get-ChildItem -Path $rootApps, $rootUser -ErrorAction Stop | Out-Null
        }
        catch {
            Remove-Item -Path $rootApps, $rootUser -Force -Verbose -ErrorAction SilentlyContinue
        }
    }
    else {
        Write-Host "`nPrompt cancelled." -ForegroundColor Yellow
    }
}
else {
    Write-Host "`nError: The profile '$folderName' does not exist." -ForegroundColor Red
}
