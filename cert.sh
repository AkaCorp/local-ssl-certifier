#!/bin/bash

# Function to install mkcert on macOS
install_mkcert_macos() {
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is not installed. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Install mkcert
    if ! command -v mkcert &> /dev/null; then
        echo "mkcert is not installed. Installing mkcert..."
        brew install mkcert
        brew install nss # For browsers based on NSS
    else
        echo "mkcert is already installed."
    fi
}

# Function to install mkcert on Linux
install_mkcert_linux() {
    echo "Checking for package manager..."
    if command -v apt-get &> /dev/null; then
        echo "Using apt-get to install mkcert..."
        sudo apt-get update
        sudo apt-get install -y mkcert
    elif command -v dnf &> /dev/null; then
        echo "Using dnf to install mkcert..."
        sudo dnf install -y mkcert
    elif command -v snap &> /dev/null; then
        echo "Using snap to install mkcert..."
        sudo snap install mkcert
    else
        echo "Package manager not found. Please install mkcert manually."
        exit 1
    fi
}

# Function to install mkcert on Windows (using Chocolatey)
install_mkcert_windows() {
    echo "Installing mkcert on Windows, please ensure Chocolatey is installed..."
    choco install mkcert
}

# Check the OS and call appropriate installation function
if [[ "$OSTYPE" == "darwin"* ]]; then
    install_mkcert_macos
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    install_mkcert_linux
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" ]]; then
    install_mkcert_windows
else
    echo "Error: Unsupported OS."
    exit 1
fi

# Install mkcert CA
mkcert -install

# Prompt the user for the domain they want to certify
read -p "Enter the domain you want to certify (e.g. subdomain.localhost or localhost): " domain

# Create an ssl directory
mkdir -p ssl

# Generate the certificate for the specified domain
mkcert "$domain"

# Move the generated certificates to the ssl directory
mv "$domain"*.pem ssl/

echo "Certificate for '$domain' has been created."
