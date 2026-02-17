# GitHub Setup and Push Script
# Run this script from the portfolio directory

param(
    [Parameter(Mandatory=$false)]
    [string]$GitHubToken = "",
    
    [Parameter(Mandatory=$false)]
    [string]$RepoUrl = ""
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "GitHub Push Script" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Check if git is initialized
if (-not (Test-Path ".git")) {
    Write-Host "Initializing Git repository..." -ForegroundColor Yellow
    git init
}

# Add all files
Write-Host "Adding files to git..." -ForegroundColor Yellow
git add .

# Create initial commit
Write-Host "Creating initial commit..." -ForegroundColor Yellow
git commit -m "Initial commit - Portfolio app with GT logo, splash screen, API 36, edge-to-edge support"

# If token provided, use it
if ($GitHubToken -ne "") {
    $remoteUrl = "https://$GitHubToken@github.com/$RepoUrl.git"
    Write-Host "Adding remote with token..." -ForegroundColor Yellow
    git remote add origin $remoteUrl 2>$null
    
    Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
    git branch -M main
    git push -u origin main
    
    Write-Host "Done! Code pushed to GitHub." -ForegroundColor Green
}
else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Yellow
    Write-Host "No GitHub token provided." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "To push to GitHub, you need to either:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Option 1: Using Personal Access Token" -ForegroundColor White
    Write-Host "1. Go to: https://github.com/settings/tokens" -ForegroundColor Gray
    Write-Host "2. Generate new token (Classic) with 'repo' scope" -ForegroundColor Gray
    Write-Host "3. Run: .\setup_github.ps1 -GitHubToken 'YOUR_TOKEN' -RepoUrl 'username/repo-name'" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Option 2: Using GitHub CLI" -ForegroundColor White
    Write-Host "1. Install GitHub CLI: https://cli.github.com/" -ForegroundColor Gray
    Write-Host "2. Run: gh auth login" -ForegroundColor Gray
    Write-Host "3. Run: git remote add origin https://github.com/username/repo.git" -ForegroundColor Gray
    Write-Host "4. Run: git push -u origin main" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Option 3: Manual Push" -ForegroundColor White
    Write-Host "1. Create repository on GitHub.com" -ForegroundColor Gray
    Write-Host "2. Copy the push commands shown on GitHub" -ForegroundColor Gray
    Write-Host ""
}
