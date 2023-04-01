#!/bin/bash
# Title : update all
# Author: Robert van Bregt 
# Last update: 2023-04-01

# Upgrade outdated Mac App Store applications
mas upgrade

# Update homebrew
brew update

# Update homebrew packages
brew upgrade

# Upgrade casks
brew upgrade --cask

# Cleanup homebrew
brew cleanup
brew autoremove
rm -rf $(brew --cache)

# Update python
pip3 install --upgrade pip

# Update outdated packages
# https://stackoverflow.com/a/27071962
pip3 install -U `pip3 list --outdated | awk 'NR>2 {print $1}'`