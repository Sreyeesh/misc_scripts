#!/bin/bash

# Function to check if brew is installed
check_brew() {
    if ! command -v brew &> /dev/null; then
        echo "Homebrew is not installed. Installing..."
        # Install Homebrew
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew is already installed."
    fi
}

# Function to install tree using brew
install_tree() {
    echo "Installing tree using Homebrew..."
    brew install tree
}

# Call the function to check for Homebrew
check_brew

# Call the function to install tree using brew
install_tree
