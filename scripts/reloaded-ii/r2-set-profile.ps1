$targetDirectory = "$PSScriptRoot\_Profiles"

if (Test-Path "$PSScriptRoot\Mods.orig") {
    Write-Host "Test Mode is currently enabled. Please disable it first before setting a profile as active." -ForegroundColor Red
    exit
}

Write-Host "Available profiles:" -ForegroundColor Cyan
Get-ChildItem -Path $targetDirectory -Directory | Select-Object -ExpandProperty Name

$folderName = Read-Host -Prompt "`nEnter the name of the profile to enable"

if ([string]::IsNullOrWhiteSpace($folderName)) {
    Write-Host "`nError: You did not enter a profile name. Please try again." -ForegroundColor Red
    exit
}

$fullPath = Join-Path -Path $targetDirectory -ChildPath $folderName

if (Test-Path -Path $fullPath -PathType Container) {
    Write-Host "`nNote: This script will close Reloaded-II to prevent any potential data loss." -ForegroundColor Yellow
    $confirm = Read-Host -Prompt "Are you sure you want to set '$folderName' as active? (Y)"

    if ($confirm -eq 'YES' -or $confirm -eq 'Y' -or $confirm -eq '') {
        Write-Host "`nAttempting to close the app..."
        Stop-Process -Name 'reloaded-ii' -Force -Verbose -ErrorAction SilentlyContinue
        Start-Sleep 1

        $profileApps = "$fullPath\Apps"
        $profileUser = "$fullPath\User"
        $rootApps = "$PSScriptRoot\Apps"
        $rootUser = "$PSScriptRoot\User"

        Remove-Item -Path $rootApps, $rootUser -Force -Recurse -ErrorAction SilentlyContinue

        New-Item -Path $profileApps, $profileUser -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

        New-Item -Path $rootApps -Target $profileApps -ItemType Junction | Out-Null
        New-Item -Path $rootUser -Target $profileUser -ItemType Junction | Out-Null

        Write-Host "`nProfile '$folderName' has been set as active." -ForegroundColor Green
    }
    else {
        Write-Host "`nPrompt cancelled." -ForegroundColor Yellow
    }
}
else {
    Write-Host "`nError: The profile '$folderName' does not exist." -ForegroundColor Red
}
