# PowerShell script to set up Git repository and push to GitHub
# This script will check for Git and guide you through the process

Write-Host "=== Git Repository Setup Script ===" -ForegroundColor Cyan
Write-Host ""

# Check if Git is installed
$gitInstalled = Get-Command git -ErrorAction SilentlyContinue

if (-not $gitInstalled) {
    Write-Host "Git is not installed on your system." -ForegroundColor Red
    Write-Host ""
    Write-Host "Please install Git first:" -ForegroundColor Yellow
    Write-Host "1. Download from: https://git-scm.com/download/win" -ForegroundColor Cyan
    Write-Host "2. Install Git with default settings" -ForegroundColor Cyan
    Write-Host "3. Restart PowerShell/terminal after installation" -ForegroundColor Cyan
    Write-Host "4. Run this script again" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Alternative: Use GitHub Desktop (GUI): https://desktop.github.com/" -ForegroundColor Green
    Write-Host ""
    
    # Offer to open download page
    $response = Read-Host "Would you like to open the Git download page? (Y/N)"
    if ($response -eq 'Y' -or $response -eq 'y') {
        Start-Process "https://git-scm.com/download/win"
    }
    
    exit
}

Write-Host "Git is installed! Version:" -ForegroundColor Green
git --version
Write-Host ""

# Check if already a git repository
if (Test-Path ".git") {
    Write-Host "Git repository already initialized." -ForegroundColor Yellow
    Write-Host ""
    $response = Read-Host "Do you want to continue with adding files and committing? (Y/N)"
    if ($response -ne 'Y' -and $response -ne 'y') {
        exit
    }
} else {
    Write-Host "Initializing Git repository..." -ForegroundColor Cyan
    git init
    Write-Host "Repository initialized!" -ForegroundColor Green
    Write-Host ""
}

# Check if there are changes to commit
$status = git status --porcelain
if ($status) {
    Write-Host "Adding all files to staging area..." -ForegroundColor Cyan
    git add .
    Write-Host "Files added!" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "Creating initial commit..." -ForegroundColor Cyan
    git commit -m "Initial commit: Framer portfolio project with server scripts and documentation"
    Write-Host "Commit created!" -ForegroundColor Green
    Write-Host ""
} else {
    Write-Host "No changes to commit. Repository is up to date." -ForegroundColor Yellow
    Write-Host ""
}

# Check if remote is already set
$remote = git remote get-url origin -ErrorAction SilentlyContinue
if ($remote) {
    Write-Host "Remote repository already configured:" -ForegroundColor Yellow
    Write-Host "  $remote" -ForegroundColor Cyan
    Write-Host ""
    $response = Read-Host "Do you want to push to this remote? (Y/N)"
    if ($response -eq 'Y' -or $response -eq 'y') {
        Write-Host ""
        Write-Host "Pushing to GitHub..." -ForegroundColor Cyan
        git branch -M main
        git push -u origin main
        Write-Host ""
        Write-Host "Successfully pushed to GitHub!" -ForegroundColor Green
    }
} else {
    Write-Host "No remote repository configured." -ForegroundColor Yellow
    Write-Host ""
    Write-Host "To connect to GitHub:" -ForegroundColor Cyan
    Write-Host "1. Create a new repository on GitHub.com" -ForegroundColor White
    Write-Host "2. Copy the repository URL (e.g., https://github.com/username/repo-name.git)" -ForegroundColor White
    Write-Host "3. Run the following commands:" -ForegroundColor White
    Write-Host ""
    Write-Host "   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git" -ForegroundColor Green
    Write-Host "   git branch -M main" -ForegroundColor Green
    Write-Host "   git push -u origin main" -ForegroundColor Green
    Write-Host ""
    
    $repoUrl = Read-Host "Or enter your GitHub repository URL now (leave empty to skip)"
    if ($repoUrl) {
        Write-Host ""
        Write-Host "Adding remote repository..." -ForegroundColor Cyan
        git remote add origin $repoUrl
        Write-Host "Remote added!" -ForegroundColor Green
        Write-Host ""
        
        Write-Host "Renaming branch to main..." -ForegroundColor Cyan
        git branch -M main
        Write-Host ""
        
        Write-Host "Pushing to GitHub..." -ForegroundColor Cyan
        Write-Host "You may be prompted for credentials." -ForegroundColor Yellow
        git push -u origin main
        Write-Host ""
        Write-Host "Successfully pushed to GitHub!" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "=== Setup Complete ===" -ForegroundColor Green
Write-Host ""


