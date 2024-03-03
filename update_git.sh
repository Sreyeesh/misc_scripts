#!/bin/bash

# Check if Git is installed
if ! [ -x "$(command -v git)" ]; then
  echo "Git is not installed. Installing Git..."
  
  # Install Git
  sudo apt-get update
  sudo apt-get install -y git
  
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
  
  # Get latest Git version from GitHub releases
  latest_version=$(curl -sL https://api.github.com/repos/git/git/releases/latest | grep '"tag_name":' | cut -d'"' -f4)
  echo "Latest Git version: $latest_version"
  
  # Compare versions
  if [[ "$installed_version" == "$latest_version" ]]; then
    echo "Git is up to date."
  else
    echo "Git is outdated. Updating Git..."
    
    # Download latest Git version
    sudo apt-get update
    sudo apt-get install -y software-properties-common
    sudo add-apt-repository ppa:git-core/ppa -y
    sudo apt-get update
    sudo apt-get install -y git
    
    # Check if update was successful
    if [ $? -eq 0 ]; then
      echo "Git update successful."
    else
      echo "Failed to update Git."
      exit 1
    fi
  fi
fi
