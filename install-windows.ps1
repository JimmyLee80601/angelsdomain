# Angel's Domain — Windows 10 Installer
# Creates a desktop shortcut that opens the novel in Edge app mode
# Run: Right-click → Run with PowerShell 7

Write-Host ""
Write-Host "    ╔═══════════════════════════════════════════════╗" -ForegroundColor DarkRed
Write-Host "    ║       ANGEL'S DOMAIN — App Installer          ║" -ForegroundColor Red
Write-Host "    ╚═══════════════════════════════════════════════╝" -ForegroundColor DarkRed
Write-Host ""

$scriptPath = $PSScriptRoot
if (-not $scriptPath) { $scriptPath = (Get-Location).Path }

# Verify files
$required = @("index.html", "scenes.json", "manifest.json", "sw.js")
$missing = @()
foreach ($f in $required) {
    if (-not (Test-Path (Join-Path $scriptPath $f))) { $missing += $f }
}
if ($missing.Count -gt 0) {
    Write-Host "Missing files: $($missing -join ', ')" -ForegroundColor Red
    exit 1
}

# Create app directory in Program Files
$appDir = "$env:LOCALAPPDATA\AngelsDomain"
if (-not (Test-Path $appDir)) { New-Item -ItemType Directory -Path $appDir -Force | Out-Null }
Copy-Item "$scriptPath\*" $appDir -Recurse -Force
Write-Host "App installed to: $appDir" -ForegroundColor Green

# Create desktop shortcut (Edge app mode — no browser chrome, feels native)
$WshShell = New-Object -ComObject WScript.Shell
$shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\Angel's Domain.lnk")
$shortcut.TargetPath = "msedge"
$shortcut.Arguments = "--app=`"file:///$($appDir -replace '\\','/')/index.html`" --user-data-dir=`"$appDir\profile`""
$shortcut.IconLocation = "$appDir\images\angel_portrait.svg"
$shortcut.WorkingDirectory = $appDir
$shortcut.Description = "Angels Domain - A Dark Gothic Fantasy"
$shortcut.Save()

Write-Host "Desktop shortcut created!" -ForegroundColor Green
Write-Host ""
Write-Host "To play: Double-click 'Angel's Domain' on your Desktop" -ForegroundColor Yellow
Write-Host "Or open index.html in any browser" -ForegroundColor DarkGray
Write-Host ""

# Also create a Start Menu entry
$startMenuDir = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"
$startShortcut = $WshShell.CreateShortcut("$startMenuDir\Angel's Domain.lnk")
$startShortcut.TargetPath = "msedge"
$startShortcut.Arguments = "--app=`"file:///$($appDir -replace '\\','/')/index.html`" --user-data-dir=`"$appDir\profile`""
$startShortcut.IconLocation = "$appDir\images\angel_portrait.svg"
$startShortcut.WorkingDirectory = $appDir
$startShortcut.Description = "Angels Domain - A Dark Gothic Fantasy"
$startShortcut.Save()

Write-Host "Start Menu entry created!" -ForegroundColor Green
Write-Host ""
