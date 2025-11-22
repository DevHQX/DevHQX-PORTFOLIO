# PowerShell script to start a simple HTTP server
$port = 8000
$url = "http://localhost:$port/imaginative-screens-471831.framer.app/"

Write-Host "Starting HTTP server on port $port..." -ForegroundColor Green
Write-Host "Server will be available at: $url" -ForegroundColor Yellow
Write-Host "Press Ctrl+C to stop the server" -ForegroundColor Yellow
Write-Host ""

# Check if Python is available
$python = Get-Command python -ErrorAction SilentlyContinue
if ($python) {
    Write-Host "Using Python HTTP server..." -ForegroundColor Cyan
    Start-Process python -ArgumentList "-m", "http.server", $port -NoNewWindow
    Start-Sleep -Seconds 2
    Start-Process $url
    Write-Host "Server started! Browser should open automatically." -ForegroundColor Green
    Write-Host "Press any key to stop the server..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    Get-Process python | Where-Object {$_.CommandLine -like "*http.server*"} | Stop-Process
} else {
    # Check if Node.js is available
    $node = Get-Command node -ErrorAction SilentlyContinue
    if ($node) {
        Write-Host "Python not found. Using Node.js http-server..." -ForegroundColor Cyan
        Write-Host "Installing http-server globally (if needed)..." -ForegroundColor Yellow
        npx --yes http-server -p $port
    } else {
        Write-Host "Neither Python nor Node.js found!" -ForegroundColor Red
        Write-Host "Please install Python from https://www.python.org/" -ForegroundColor Yellow
        Write-Host "Or install Node.js from https://nodejs.org/" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "Alternatively, you can open the HTML file directly:" -ForegroundColor Cyan
        Write-Host "imaginative-screens-471831.framer.app\index.html" -ForegroundColor White
        pause
    }
}

