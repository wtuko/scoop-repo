$targetDirectory = "$PSScriptRoot\_Profiles"

Write-Host "Available profiles:" -ForegroundColor Cyan
Get-ChildItem -Path $targetDirectory -Directory | Select-Object -ExpandProperty Name

$currentName = Read-Host -Prompt "`nEnter the name of the profile you want to rename"
if ([string]::IsNullOrWhiteSpace($currentName)) {
    Write-Host "`nError: You did not enter a profile name. Please try again." -ForegroundColor Red
    exit
}

$currentPath = Join-Path -Path $targetDirectory -ChildPath $currentName
if (!(Test-Path -Path $currentPath -PathType Container)) {
    Write-Host "`nError: The profile '$currentName' does not exist." -ForegroundColor Red
    exit
}

$newName = Read-Host -Prompt "Enter the new name for this profile (case insensitive)"
if ([string]::IsNullOrWhiteSpace($newName)) {
    Write-Host "`nError: You did not enter a new name. Please try again." -ForegroundColor Red
    exit
}

$newPath = Join-Path -Path $targetDirectory -ChildPath $newName
if (Test-Path -Path $newPath) {
    Write-Host "`nError: A profile named '$newName' already exists. Please choose a different name." -ForegroundColor Red
    exit
}

Write-Host "`nNote: This script will close Reloaded-II to prevent any potential data loss." -ForegroundColor Yellow
$confirm = Read-Host -Prompt "Are you sure you want to rename '$currentName' to '$newName'? (Y)"
if ($confirm -eq 'YES' -or $confirm -eq 'Y' -or $confirm -eq '') {
    Write-Host "`nAttempting to close the app..."
    Stop-Process -Name 'reloaded-ii' -Force -Verbose -ErrorAction SilentlyContinue
    Start-Sleep 1

    $profileApps = "$newPath\Apps"
    $profileUser = "$newPath\User"
    $rootApps = "$PSScriptRoot\Apps"
    $rootUser = "$PSScriptRoot\User"

    try {
        Rename-Item -Path $currentPath -NewName $newName -ErrorAction Stop
        Write-Host "`nProfile '$currentName' has been renamed to '$newName'." -ForegroundColor Green
    }
    catch {
        Write-Host "`nError: Failed to rename the profile. Details: $_" -ForegroundColor Red
        exit
    }

    try {
        Get-ChildItem -Path $rootApps, $rootUser -ErrorAction Stop | Out-Null
    }
    catch {
        Remove-Item -Path $rootApps, $rootUser -Force -Recurse -ErrorAction SilentlyContinue

        New-Item -Path $profileApps, $profileUser -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

        New-Item -Path $rootApps -Target $profileApps -ItemType Junction | Out-Null
        New-Item -Path $rootUser -Target $profileUser -ItemType Junction | Out-Null

        Write-Host "`nProfile '$newName' has been set as active due to recent name change." -ForegroundColor Green
    }
}
else {
    Write-Host "`nPrompt cancelled." -ForegroundColor Yellow
}
