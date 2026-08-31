param([Parameter(Mandatory)][String] $dir, [Parameter(Mandatory)][String] $persist_dir, [Parameter(Mandatory)][String] $cmd)

$persist_dir = (Resolve-Path "$persist_dir\..\quicklook\UserData\QuickLook.Plugin").Path
$plugin_name = (Get-Item "$dir\..").Name

Stop-Process -Name 'QuickLook' -Force -ErrorAction SilentlyContinue; Start-Sleep 1

if ($cmd -eq 'pre_install') {
    New-Item -Path "$persist_dir\$plugin_name" -Target "$dir" -ItemType SymbolicLink | Out-Null
} elseif ($cmd -eq 'pre_uninstall') {
    Remove-Item -Path "$persist_dir\$plugin_name" -Force
}
