#!/bin/bash

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "Error: Node.js is not installed. Please install Node.js first."
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "Error: npm is not installed. Please install npm first."
    exit 1
fi

# Check if mkcert is installed locally (in node_modules)
if ! [ -x "./node_modules/.bin/mkcert" ]; then
    echo "mkcert is not installed locally. Installing mkcert..."
    npm install mkcert
else
    echo "mkcert is already installed locally."
fi

# Install mkcert CA
./node_modules/.bin/mkcert -install

# Prompt the user for the domain they want to certify
read -p "Enter the domain you want to certify (e.g. subdomain1.localhost or localhost or other): " domain

# Create an ssl directory
mkdir -p ssl

# Generate the certificate for the specified domain
./node_modules/.bin/mkcert "$domain"

# Move the generated certificates to the ssl directory
mv "$domain"*.pem ssl/

echo "Certificate for '$domain' has been created."

