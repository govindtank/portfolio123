# Build Release APK Script
# Run this script to generate a release APK for Play Store upload

Write-Host "Building Release APK for Play Store..." -ForegroundColor Cyan

# Clean previous builds
Write-Host "Cleaning previous builds..." -ForegroundColor Yellow
flutter clean

# Get dependencies
Write-Host "Getting dependencies..." -ForegroundColor Yellow
flutter pub get

# Build release APK (universal APK without splits for Play Store)
Write-Host "Building release APK..." -ForegroundColor Yellow
flutter build apk --release

# Alternatively, if you want to build with splits:
# flutter build apk --release --split-per-abi

# Check if build was successful
if (Test-Path "build/app/outputs/flutter-apk/app-release.apk") {
    Write-Host "Build successful!" -ForegroundColor Green
    Write-Host "APK location: build/app/outputs/flutter-apk/app-release.apk" -ForegroundColor Cyan
} elseif (Test-Path "build/app/outputs/apk/release/app-release.apk") {
    Write-Host "Build successful!" -ForegroundColor Green
    Write-Host "APK location: build/app/outputs/apk/release/app-release.apk" -ForegroundColor Cyan
} else {
    Write-Host "Build may have failed. Check the output above." -ForegroundColor Red
}
