Write-Host "=== Reloaded-II Directory ===" -ForegroundColor Cyan
Get-ChildItem -Path $PSScriptRoot -Filter Apps | ForEach-Object {Write-Host "$($_.Name) ($($_.LinkTarget))"}
Get-ChildItem -Path $PSScriptRoot -Filter User | ForEach-Object {Write-Host "$($_.Name) ($($_.LinkTarget))"}

Write-Host "`n=== Profiles List ===" -ForegroundColor Cyan
Get-ChildItem -Path $PSScriptRoot\_Profiles | Select-Object -ExpandProperty Name

Write-Host "`n=== Commands List ===" -ForegroundColor Cyan
Get-ChildItem -Path $PSScriptRoot\* -Include r2-*.ps1 | Select-Object -ExpandProperty Name