# Build Flutter Web Script for Portfolio App
# This script builds the web version and prepares it for deployment

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Building Flutter Web for Portfolio App" -ForegroundColor Cyan
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
$projectDir = Split-Path -Parent $PSScriptRoot
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

# Clean previous builds
Write-Host "Cleaning previous web builds..." -ForegroundColor Yellow
flutter clean
Write-Host "Clean complete!" -ForegroundColor Green
Write-Host ""

# Build web release
Write-Host "Building web release (CanvasKit renderer)..." -ForegroundColor Yellow
Write-Host "This may take a few minutes..." -ForegroundColor Yellow
flutter build web --release --base-href "/portfolio/" --web-renderer canvaskit
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Failed to build web release" -ForegroundColor Red
    exit 1
}
Write-Host "Web build successful!" -ForegroundColor Green
Write-Host ""

# Create .nojekyll for GitHub Pages
$nojekyllPath = "build\web\.nojekyll"
New-Item -Path $nojekyllPath -ItemType File -Force | Out-Null
Write-Host "Created .nojekyll file for GitHub Pages" -ForegroundColor Green

# Check build output
$indexPath = "build\web\index.html"
if (Test-Path $indexPath) {
    $buildSize = (Get-ChildItem "build\web\" -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Build Summary" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "Build Output: build\web\" -ForegroundColor Green
    Write-Host "Total Size: $([math]::Round($buildSize, 2)) MB" -ForegroundColor Green
    Write-Host ""
    Write-Host "To deploy to GitHub Pages:" -ForegroundColor Yellow
    Write-Host "  Option 1: Push to main branch (auto-deploys via GitHub Actions)" -ForegroundColor White
    Write-Host "  Option 2: Copy build\web\ contents to gh-pages branch" -ForegroundColor White
    Write-Host "  Option 3: Use GitHub Actions artifact upload" -ForegroundColor White
    Write-Host ""
    Write-Host "Local preview: Open build\web\index.html in a browser" -ForegroundColor Yellow
    Write-Host "========================================" -ForegroundColor Cyan
} else {
    Write-Host "ERROR: index.html not found in build output" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Build completed successfully!" -ForegroundColor Green
