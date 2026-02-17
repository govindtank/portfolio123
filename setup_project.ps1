# Create necessary directories
$directories = @(
    "assets/animations",
    "assets/icons",
    "assets/images",
    "assets/fonts",
    "lib/core/constants",
    "lib/core/theme",
    "lib/core/utils",
    "lib/core/widgets",
    "lib/features/home",
    "lib/features/about",
    "lib/features/skills",
    "lib/features/projects",
    "lib/features/experience",
    "lib/features/contact",
    "lib/features/settings",
    "lib/models",
    "lib/routes",
    "lib/services"
)

foreach ($dir in $directories) {
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
        Write-Host "Created directory: $dir"
    }
}

# Create .env file if it doesn't exist
if (-not (Test-Path ".env")) {
    @"
# Environment Variables
APP_NAME="Portfolio"
APP_VERSION=1.0.0
BUILD_NUMBER=1
ENVIRONMENT=development

# API Endpoints
API_BASE_URL=https://api.example.com
API_TIMEOUT=30000

# Analytics
ENABLE_ANALYTICS=false
GOOGLE_ANALYTICS_ID=

# Social Media Links
GITHUB_URL=
LINKEDIN_URL=
TWITTER_URL=
INSTAGRAM_URL=
"@ | Out-File -FilePath ".env" -Encoding utf8
    Write-Host "Created .env file"
}

Write-Host "Project setup completed successfully!" -ForegroundColor Green
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Add your Lottie animations to assets/animations/"
Write-Host "2. Add your app icons to assets/icons/"
Write-Host "3. Add your images to assets/images/"
Write-Host "4. Add your custom fonts to assets/fonts/"
Write-Host "5. Run 'flutter pub get' to install dependencies"
Write-Host "6. Run 'flutter pub run flutter_launcher_icons' to generate launcher icons"
Write-Host "7. Run 'flutter pub run flutter_native_splash:create' to generate splash screen"
