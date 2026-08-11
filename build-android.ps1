# Angel's Domain — Android APK Builder
# Uses Capacitor to wrap the web app in a native Android shell
# Requires: Node.js, Java JDK, Android SDK (or Android Studio)
# Run: Right-click → Run with PowerShell 7

Write-Host ""
Write-Host "    ╔═══════════════════════════════════════════════╗" -ForegroundColor DarkRed
Write-Host "    ║       ANGEL'S DOMAIN — Android Builder        ║" -ForegroundColor Red
Write-Host "    ╚═══════════════════════════════════════════════╝" -ForegroundColor DarkRed
Write-Host ""

$scriptPath = $PSScriptRoot
if (-not $scriptPath) { $scriptPath = (Get-Location).Path }

# Check prerequisites
Write-Host "Checking prerequisites..." -ForegroundColor DarkGray

$node = Get-Command node -ErrorAction SilentlyContinue
if (-not $node) {
    Write-Host "Node.js not found. Install from https://nodejs.org" -ForegroundColor Red
    Write-Host "After installing, restart PowerShell and run this script again." -ForegroundColor Yellow
    exit 1
}
Write-Host "  Node.js: $(node --version)" -ForegroundColor Green

$java = Get-Command java -ErrorAction SilentlyContinue
if (-not $java) {
    Write-Host "Java JDK not found. Install from https://adoptium.net" -ForegroundColor Red
    Write-Host "Or install Android Studio which includes Java." -ForegroundColor Yellow
    exit 1
}
Write-Host "  Java: found" -ForegroundColor Green

# Create build directory
$buildDir = Join-Path $scriptPath "android-build"
if (Test-Path $buildDir) {
    Write-Host "Cleaning previous build..." -ForegroundColor Yellow
    Remove-Item $buildDir -Recurse -Force
}

Write-Host ""
Write-Host "Setting up Capacitor project..." -ForegroundColor Cyan

# Initialize npm project
New-Item -ItemType Directory -Path $buildDir -Force | Out-Null
Set-Location $buildDir

# Create package.json
$packageJson = @"
{
  "name": "angels-domain",
  "version": "2.0.0",
  "description": "Angel's Domain - A Dark Gothic Fantasy",
  "main": "index.js",
  "scripts": {
    "build": "echo done"
  }
}
"@
Set-Content "package.json" $packageJson

# Install Capacitor
Write-Host "Installing Capacitor (this may take a minute)..." -ForegroundColor DarkGray
npm install @capacitor/core @capacitor/cli @capacitor/android 2>$null | Out-Null

if (-not (Test-Path "node_modules\@capacitor\core")) {
    Write-Host "Capacitor install failed. Check your internet connection." -ForegroundColor Red
    exit 1
}
Write-Host "  Capacitor installed" -ForegroundColor Green

# Create capacitor.config.json
$capConfig = @"
{
  "appId": "com.angelsdomain.app",
  "appName": "Angel's Domain",
  "webDir": "www",
  "server": {
    "androidScheme": "https"
  },
  "plugins": {
    "SplashScreen": {
      "launchAutoHide": true,
      "backgroundColor": "#0a0a0a",
      "showSpinner": false
    },
    "StatusBar": {
      "style": "DARK",
      "backgroundColor": "#0a0a0a"
    }
  }
}
"@
Set-Content "capacitor.config.json" $capConfig

# Copy web assets
Write-Host "Copying web assets..." -ForegroundColor DarkGray
New-Item -ItemType Directory -Path "www" -Force | Out-Null
Copy-Item "$scriptPath\index.html" "www\"
Copy-Item "$scriptPath\scenes.json" "www\"
Copy-Item "$scriptPath\manifest.json" "www\"
Copy-Item "$scriptPath\sw.js" "www\"
Copy-Item "$scriptPath\favicon.svg" "www\"
New-Item -ItemType Directory -Path "www\images" -Force | Out-Null
Copy-Item "$scriptPath\images\*" "www\images\" -Recurse -Force

# Initialize Capacitor Android
Write-Host "Initializing Android platform..." -ForegroundColor DarkGray
npx cap add android 2>$null | Out-Null

if (-not (Test-Path "android")) {
    Write-Host "Failed to add Android platform. Check Android SDK installation." -ForegroundColor Red
    Write-Host "Install Android Studio: https://developer.android.com/studio" -ForegroundColor Yellow
    exit 1
}
Write-Host "  Android platform added" -ForegroundColor Green

# Copy web assets to Android
npx cap copy android 2>$null | Out-Null

# Build APK
Write-Host ""
Write-Host "Building APK..." -ForegroundColor Cyan

$gradlew = "android\gradlew.bat"
if (-not (Test-Path $gradlew)) {
    $gradlew = "android\gradlew"
}

# Try to build debug APK
Push-Location "android"
try {
    & .\gradlew.bat assembleDebug 2>&1 | Out-Null
} catch {
    Write-Host "Gradle build failed. Trying alternative..." -ForegroundColor Yellow
    & .\gradlew assembleDebug 2>&1 | Out-Null
}
Pop-Location

$apkPath = "android\app\build\outputs\apk\debug\app-debug.apk"
if (Test-Path $apkPath) {
    # Copy APK to Desktop
    $desktopApk = "$env:USERPROFILE\Desktop\AngelsDomain.apk"
    Copy-Item $apkPath $desktopApk -Force
    
    Write-Host ""
    Write-Host "═══════════════════════════════════════════════════" -ForegroundColor DarkRed
    Write-Host "  BUILD COMPLETE!" -ForegroundColor Green
    Write-Host "═══════════════════════════════════════════════════" -ForegroundColor DarkRed
    Write-Host ""
    Write-Host "APK saved to: $desktopApk" -ForegroundColor White
    Write-Host ""
    Write-Host "To install on your Android phone:" -ForegroundColor Yellow
    Write-Host "  1. Connect phone via USB" -ForegroundColor White
    Write-Host "  2. Enable USB Debugging in Developer Options" -ForegroundColor White
    Write-Host "  3. Run: adb install `"$desktopApk`"" -ForegroundColor White
    Write-Host "  Or transfer the APK to your phone and tap to install" -ForegroundColor White
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "APK build failed. Possible causes:" -ForegroundColor Red
    Write-Host "  - Android SDK not installed (install Android Studio)" -ForegroundColor Yellow
    Write-Host "  - Java JDK not configured" -ForegroundColor Yellow
    Write-Host "  - Gradle not available" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Alternative: Use the Windows version or open index.html in Chrome" -ForegroundColor DarkGray
    Write-Host "  Chrome on Android → Menu → 'Add to Home Screen' for app-like experience" -ForegroundColor DarkGray
}

Set-Location $scriptPath
