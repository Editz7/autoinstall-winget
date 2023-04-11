# Check if Chocolatey is installed
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    # Prompt the user to install Chocolatey
    $installChoco = Read-Host "Chocolatey is not installed. Do you want to install it? (Y/N)"
    if ($installChoco -eq "Y") {
        # Download and install Chocolatey
        Set-ExecutionPolicy Bypass -Scope Process -Force
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
        Write-Host "Chocolatey installed successfully!"
    } else {
        Write-Host "Chocolatey installation cancelled."
        exit
    }
}

# Define a list of applications to install
$applications = "7zip", "obs-studio", "discord", "chromium", "telegram"

# Loop through the list of applications and install them using Chocolatey
foreach ($app in $applications) {
    Write-Host "Installing $app ..."
    choco install $app -y
}

Write-Host "All applications installed successfully!"
