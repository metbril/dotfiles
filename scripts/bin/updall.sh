#!/bin/bash
# Title : update all
# Author: Robert van Bregt 
# Last update: 2023-05-05

# Update outdated Mac App Store applications
echo Update from Mac App Store...
mas upgrade

# Update homebrew
echo Update Homebrew...
brew update

# Update homebrew packages
echo Update Homebrew packages...
brew upgrade

# Upgrade casks
echo Update Homebrew casks...
brew upgrade --cask

# Cleanup homebrew
echo Cleanup Homebrew...
brew cleanup
brew autoremove
rm -rf $(brew --cache)

# Update python
echo Update Python packages...
pip3 install --upgrade pip

# Update outdated packages
# https://stackoverflow.com/a/27071962
echo Update outdated Python packages
pip3 install -U `pip3 list --outdated | awk 'NR>2 {print $1}'`
