#!/bin/bash

# Check if Homebrew is installed
if ! [ -x "$(command -v brew)" ]; then
  echo "Homebrew is not installed. Installing Homebrew..."
  
  # Install Homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  
  # Check if installation was successful
  if [ $? -eq 0 ]; then
    echo "Homebrew installation successful."
  else
    echo "Failed to install Homebrew."
    exit 1
  fi
fi

# Check if Git is installed
if ! [ -x "$(command -v git)" ]; then
  echo "Git is not installed. Installing Git..."
  
  # Install Git using Homebrew
  brew install git
  
  # Check if installation was successful
  if [ $? -eq 0 ]; then
    echo "Git installation successful."
  else
    echo "Failed to install Git."
    exit 1
  fi
else
  # Get installed Git version
  installed_version=$(git --version | awk '{print $3}')
  echo "Installed Git version: $installed_version"
  
  # Get latest Git version from Homebrew
  latest_version=$(brew info --json=v1 git | jq -r '.[0].versions.stable')
  echo "Latest Git version: $latest_version"
  
  # Compare versions
  if [[ "$installed_version" == "$latest_version" ]]; then
    echo "Git is up to date."
  else
    echo "Git is outdated. Updating Git..."
    
    # Update Git using Homebrew
    brew upgrade git
    
    # Check if update was successful
    if [ $? -eq 0 ]; then
      echo "Git update successful."
    else
      echo "Failed to update Git."
      exit 1
    fi
  fi
fi
