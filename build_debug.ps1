# Build Debug APK Script for Portfolio App
# This script builds a debug APK for testing without requiring a keystore

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Building Debug APK for Portfolio App" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Flutter is installed
Write-Host "Checking Flutter installation..." -ForegroundColor Yellow
flutter --version
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Flutter is not installed or not in PATH" -ForegroundColor Red
    exit 1
}
Write-Host "Flutter is installed!" -ForegroundColor Green
Write-Host ""

# Navigate to the project directory
$projectDir = "portfolio"
if (-not (Test-Path $projectDir)) {
    Write-Host "ERROR: Project directory '$projectDir' not found" -ForegroundColor Red
    exit 1
}
Set-Location $projectDir
Write-Host "Working directory: $(Get-Location)" -ForegroundColor Green
Write-Host ""

# Get dependencies
Write-Host "Getting Flutter dependencies..." -ForegroundColor Yellow
flutter pub get
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Failed to get dependencies" -ForegroundColor Red
    exit 1
}
Write-Host "Dependencies installed successfully!" -ForegroundColor Green
Write-Host ""

# Build debug APK
Write-Host "Building debug APK..." -ForegroundColor Yellow
Write-Host "This may take a few minutes..." -ForegroundColor Yellow
flutter build apk --debug
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Failed to build debug APK" -ForegroundColor Red
    exit 1
}
Write-Host "Debug APK built successfully!" -ForegroundColor Green
Write-Host ""

# Check if APK was created
$apkPath = "build\app\outputs\flutter-apk\app-debug.apk"
if (Test-Path $apkPath) {
    $apkSize = (Get-Item $apkPath).Length / 1MB
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Build Summary" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "APK Location: $apkPath" -ForegroundColor Green
    Write-Host "APK Size: $([math]::Round($apkSize, 2)) MB" -ForegroundColor Green
    Write-Host ""
    Write-Host "To install on your device:" -ForegroundColor Yellow
    Write-Host "  1. Enable USB debugging on your Android device" -ForegroundColor White
    Write-Host "  2. Connect your device via USB" -ForegroundColor White
    Write-Host "  3. Run: flutter install" -ForegroundColor White
    Write-Host ""
    Write-Host "Or install manually:" -ForegroundColor Yellow
    Write-Host "  1. Copy the APK to your device" -ForegroundColor White
    Write-Host "  2. Enable 'Install from unknown sources'" -ForegroundColor White
    Write-Host "  3. Open the APK file to install" -ForegroundColor White
    Write-Host "========================================" -ForegroundColor Cyan
} else {
    Write-Host "ERROR: APK file not found at expected location" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Build completed successfully!" -ForegroundColor Green