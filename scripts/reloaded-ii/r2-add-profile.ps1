$targetDirectory = "$PSScriptRoot\_Profiles"

Write-Host "Available profiles:" -ForegroundColor Cyan
Get-ChildItem -Path $targetDirectory -Directory | Select-Object -ExpandProperty Name

$folderName = Read-Host -Prompt "`nEnter the name of the profile to create"

if ([string]::IsNullOrWhiteSpace($folderName)) {
    Write-Host "`nError: You did not enter a profile name. Please try again." -ForegroundColor Red
    exit
}

$fullPath = Join-Path -Path $targetDirectory -ChildPath $folderName

try {
    New-Item -Path $fullPath -ItemType Directory -ErrorAction Stop | Out-Null
    Write-Host "`nProfile '$folderName' has been created." -ForegroundColor Green
}
catch {
    Write-Host "`nError: Failed to create the profile. Details: $_" -ForegroundColor Red
}
