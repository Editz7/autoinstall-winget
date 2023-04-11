# Ensure the script runs with administrator privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

# Check if winget is installed
try {
    winget --version | Out-Null
} catch {
    Write-Host "winget is not installed. Please install Windows Package Manager before running this script." -ForegroundColor Red
    Exit
}

# List of preset applications to install
$appsToInstall = @(
    "7zip.7zip",
    "Discord.Discord",
    "obsproject.obs-studio",
    "Telegram.TelegramDesktop",
    "Valve.Steam"
)

# Get the list of installed packages
$installedPackages = winget list --id --name

# Install each application from the list if not already installed
foreach ($app in $appsToInstall) {
    if ($installedPackages -match $app) {
        Write-Host "$app is already installed." -ForegroundColor Green
    } else {
        Write-Host "Installing $app..." -ForegroundColor Yellow
        winget install --id $app --accept-package-agreements --accept-source-agreements -e | Out-Null
        Write-Host "$app has been installed." -ForegroundColor Green
    }
}

Write-Host "All preset applications have been processed." -ForegroundColor Green
