# Phone Number Search Tool - Windows Installer
# PowerShell script for Windows installation

param(
    [switch]$QuickRun = $false
)

# Configuration
$RepoUrl = "https://github.com/your-username/bypass-phone.git"
$InstallDir = "$env:USERPROFILE\bypass-phone"
$TempDir = "$env:TEMP\bypass-phone-$(Get-Date -Format 'yyyyMMddHHmmss')"

Write-Host "================================================" -ForegroundColor Blue
Write-Host "🔍 Phone Number Search Tool - Windows Installer" -ForegroundColor Blue
Write-Host "================================================" -ForegroundColor Blue

function Test-Command {
    param($Command)
    try {
        Get-Command $Command -ErrorAction Stop | Out-Null
        return $true
    } catch {
        return $false
    }
}

function Write-Success {
    param($Message)
    Write-Host "✅ $Message" -ForegroundColor Green
}

function Write-Error {
    param($Message)
    Write-Host "❌ $Message" -ForegroundColor Red
}

function Write-Warning {
    param($Message)
    Write-Host "⚠️ $Message" -ForegroundColor Yellow
}

function Write-Info {
    param($Message)
    Write-Host "💡 $Message" -ForegroundColor Blue
}

# Check dependencies
Write-Info "Checking dependencies..."

# Check Python
if (Test-Command "python") {
    Write-Success "Python found"
    $PythonCmd = "python"
} elseif (Test-Command "python3") {
    Write-Success "Python3 found"
    $PythonCmd = "python3"
} else {
    Write-Error "Python not found!"
    Write-Info "Please install Python 3.7+ from https://python.org"
    exit 1
}

# Check Git
if (Test-Command "git") {
    Write-Success "Git found"
} else {
    Write-Error "Git not found!"
    Write-Info "Please install Git from https://git-scm.com"
    exit 1
}

# Check Chrome
$ChromePaths = @(
    "${env:ProgramFiles}\Google\Chrome\Application\chrome.exe",
    "${env:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe",
    "${env:LOCALAPPDATA}\Google\Chrome\Application\chrome.exe"
)

$ChromeFound = $false
foreach ($Path in $ChromePaths) {
    if (Test-Path $Path) {
        $ChromeFound = $true
        break
    }
}

if ($ChromeFound) {
    Write-Success "Chrome found"
} else {
    Write-Warning "Chrome not found!"
    Write-Info "Please install Chrome from https://chrome.google.com"
}

if ($QuickRun) {
    # Quick run mode
    Write-Info "Running in quick mode..."
    
    Write-Info "Downloading from GitHub..."
    git clone $RepoUrl $TempDir --quiet
    
    Set-Location $TempDir
    
    Write-Info "Installing dependencies..."
    & $PythonCmd -m pip install -r requirements.txt --quiet
    
    Write-Info "Running Phone Number Search Tool..."
    & $PythonCmd phone_search.py
    
    Write-Info "Cleaning up..."
    Set-Location $env:USERPROFILE
    Remove-Item -Recurse -Force $TempDir
    
    Write-Success "Done!"
} else {
    # Full installation mode
    Write-Info "Installing Phone Number Search Tool..."
    
    # Remove existing installation
    if (Test-Path $InstallDir) {
        Write-Info "Removing old installation..."
        Remove-Item -Recurse -Force $InstallDir
    }
    
    # Clone repository
    Write-Info "Downloading from GitHub..."
    git clone $RepoUrl $InstallDir
    
    Set-Location $InstallDir
    
    # Install dependencies
    Write-Info "Installing dependencies..."
    & $PythonCmd -m pip install -r requirements.txt
    
    # Create batch files
    Write-Info "Creating shortcuts..."
    
    # Create run.bat
    @"
@echo off
cd /d "%~dp0"
python phone_search.py
pause
"@ | Out-File -FilePath "run.bat" -Encoding ASCII
    
    # Create run_config.bat
    @"
@echo off
cd /d "%~dp0"
if not exist "config.json" (
    echo ⚠️ File config.json does not exist!
    echo 💡 Copy from config_example.json and edit:
    echo    copy config_example.json config.json
    pause
    exit /b 1
)
python run_with_config.py config.json
pause
"@ | Out-File -FilePath "run_config.bat" -Encoding ASCII
    
    # Create uninstall.bat
    @"
@echo off
echo 🗑️ Uninstalling Phone Number Search Tool...
cd /d "%USERPROFILE%"
rmdir /s /q "bypass-phone"
echo ✅ Uninstall complete!
pause
"@ | Out-File -FilePath "uninstall.bat" -Encoding ASCII
    
    Write-Success "Installation complete!"
    
    Write-Host ""
    Write-Host "📋 Usage:" -ForegroundColor Green
    Write-Host "cd $InstallDir" -ForegroundColor Blue
    Write-Host ".\run.bat                    # Run interactive mode" -ForegroundColor Blue
    Write-Host ".\run_config.bat             # Run with config file" -ForegroundColor Blue
    Write-Host "python quick_start.py        # Quick test" -ForegroundColor Blue
    Write-Host ".\uninstall.bat              # Uninstall" -ForegroundColor Blue
    Write-Host ""
    Write-Host "📖 Documentation:" -ForegroundColor Green
    Write-Host "Get-Content README.md" -ForegroundColor Blue
    Write-Host ""
    Write-Host "🎯 To run now:" -ForegroundColor Green
    Write-Host ".\run.bat" -ForegroundColor Blue
}

Write-Host ""
Write-Success "🎉 Installation successful!" 