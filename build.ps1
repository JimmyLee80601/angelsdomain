# Angel's Domain Visual Novel Builder v2.0
# For: Jimmy Lee & Jeannine
# Run this in PowerShell 7 to build the complete package

Write-Host ""
Write-Host "    ╔═══════════════════════════════════════════════╗" -ForegroundColor DarkRed
Write-Host "    ║       ANGEL'S DOMAIN — Builder v2.0           ║" -ForegroundColor Red
Write-Host "    ╚═══════════════════════════════════════════════╝" -ForegroundColor DarkRed
Write-Host ""

$scriptPath = $PSScriptRoot
if (-not $scriptPath) { $scriptPath = (Get-Location).Path }

Write-Host "Working directory: $scriptPath" -ForegroundColor DarkGray
Write-Host ""

# Verify required files exist
$requiredFiles = @(
    "index.html",
    "scenes.json",
    "manifest.json",
    "sw.js",
    "favicon.svg",
    "images\corridor_deep_passage.jpg",
    "images\corridor_misty_approach.jpg",
    "images\corridor_the_doors.jpg",
    "images\chamber_firelit.jpg",
    "images\chamber_supernatural.jpg",
    "images\fireplace_intimate.jpg",
    "images\angel_portrait.svg",
    "images\seraphina_portrait.svg"
)

$missingFiles = @()
foreach ($file in $requiredFiles) {
    $fullPath = Join-Path $scriptPath $file
    if (-not (Test-Path $fullPath)) {
        $missingFiles += $file
    }
}

if ($missingFiles.Count -gt 0) {
    Write-Host "MISSING FILES:" -ForegroundColor Red
    foreach ($file in $missingFiles) {
        Write-Host "   $file" -ForegroundColor DarkRed
    }
    Write-Host ""
    exit 1
}

Write-Host "All required files found" -ForegroundColor Green
Write-Host ""

# Create output folder
$outputDir = Join-Path $scriptPath "Angel's Domain - Visual Novel"
if (Test-Path $outputDir) {
    Remove-Item $outputDir -Recurse -Force
}
New-Item -ItemType Directory -Path $outputDir | Out-Null

# Copy files
Copy-Item (Join-Path $scriptPath "index.html") $outputDir
Copy-Item (Join-Path $scriptPath "scenes.json") $outputDir
Copy-Item (Join-Path $scriptPath "manifest.json") $outputDir
Copy-Item (Join-Path $scriptPath "sw.js") $outputDir
Copy-Item (Join-Path $scriptPath "favicon.svg") $outputDir
New-Item -ItemType Directory -Path (Join-Path $outputDir "images") | Out-Null
Copy-Item (Join-Path $scriptPath "images") (Join-Path $outputDir "images") -Recurse -Force

Write-Host "Files copied to output folder" -ForegroundColor Green
Write-Host ""

# Create launcher shortcut
$WshShell = New-Object -ComObject WScript.Shell
$shortcutPath = Join-Path $outputDir "Start Angel's Domain.lnk"
$shortcut = $WshShell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = (Join-Path $outputDir "index.html")
$shortcut.IconLocation = "%SystemRoot%\System32\SHELL32.dll,14"
$shortcut.WorkingDirectory = $outputDir
$shortcut.Description = "Angel's Domain - A Dark Gothic Fantasy"
$shortcut.Save()

Write-Host "Launcher shortcut created" -ForegroundColor Green
Write-Host ""

# Display results
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor DarkRed
Write-Host "  BUILD COMPLETE — v2.0" -ForegroundColor Red
Write-Host "═══════════════════════════════════════════════════" -ForegroundColor DarkRed
Write-Host ""
Write-Host "Output folder: $outputDir" -ForegroundColor White
Write-Host ""
Write-Host "New in v2.0:" -ForegroundColor Cyan
Write-Host "  + Character portraits (Angel & Seraphina)" -ForegroundColor White
Write-Host "  + 15 scenes across 4 chapters" -ForegroundColor White
Write-Host "  + PWA installable (Android + Windows)" -ForegroundColor White
Write-Host "  + Touch swipe support" -ForegroundColor White
Write-Host "  + Improved responsive design" -ForegroundColor White
Write-Host ""
Write-Host "To play:" -ForegroundColor Yellow
Write-Host "  Windows: Double-click 'Start Angel's Domain.lnk'" -ForegroundColor White
Write-Host "  Or open index.html in Chrome/Edge" -ForegroundColor DarkGray
Write-Host "  Android: Open index.html in Chrome, tap Menu > Add to Home Screen" -ForegroundColor DarkGray
Write-Host ""
Write-Host "To install as app:" -ForegroundColor Yellow
Write-Host "  Windows: Run install-windows.ps1" -ForegroundColor White
Write-Host "  Android: Run build-android.ps1 (requires Android SDK)" -ForegroundColor White
Write-Host "  Or use Chrome's 'Add to Home Screen' on Android" -ForegroundColor DarkGray
Write-Host ""
Write-Host "To edit the story:" -ForegroundColor Yellow
Write-Host "  Open scenes.json in Notepad or VS Code" -ForegroundColor White
Write-Host "  Find [INSERT HERE] markers" -ForegroundColor White
Write-Host "  Replace with your and Jeannine's writing" -ForegroundColor White
Write-Host "  Save and refresh the browser" -ForegroundColor White
Write-Host ""
Write-Host "Controls:" -ForegroundColor Yellow
Write-Host "  Arrow Right / Space / Enter : Advance" -ForegroundColor White
Write-Host "  Arrow Left                   : Go back" -ForegroundColor White
Write-Host "  ESC                          : Save menu" -ForegroundColor White
Write-Host "  Click dialogue box           : Advance" -ForegroundColor White
Write-Host "  Swipe left/right (mobile)    : Navigate" -ForegroundColor White
Write-Host ""

# Open the folder
Start-Process explorer.exe $outputDir
