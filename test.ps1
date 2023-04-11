# Check if Winget is installed
if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
    # Prompt the user to install Winget
    $installWinget = Read-Host "Winget is not installed. Do you want to install it? (Y/N)"
    if ($installWinget -eq "Y") {
        # Download and install the Winget MSI from Microsoft's GitHub repository
        $wingetMsiUrl = "https://github.com/microsoft/winget-cli/releases/latest/download/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
        $wingetMsiPath = "$env:TEMP\winget.msixbundle"
        Invoke-WebRequest $wingetMsiUrl -OutFile $wingetMsiPath
        Add-AppPackage $wingetMsiPath -ErrorAction Stop
        Write-Host "Winget installed successfully!"
    } else {
        Write-Host "Winget installation cancelled."
        exit
    }
}

# Define a list of applications to install
$applications = "7zip.7zip", "OBSProject.OBSStudio", "Discord.Discord", "Chromium.Chromium", "Telegram.TelegramDesktop"

# Loop through the list of applications and install them using Winget
foreach ($app in $applications) {
    Write-Host "Installing $app ..."
    winget install $app -q
}

Write-Host "All applications installed successfully!"
