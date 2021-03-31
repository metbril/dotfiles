#!/bin/bash

### install applications once

### install command line utilities

brew update && brew upgrade

### bypass apple system default ruby :)
### this will let gems install without issues
brew install ruby

# Install Python - including bypass Apple system default :)

brew install python
brew install python3
pip3 install --upgrade pip setuptools wheel
pip3 completion --bash >> ~/.extra

### install command line tools

brew install exiftool
brew install ffmpeg
brew install imagemagick
brew install jpegoptim
brew install jrnl
brew install keybase
brew install multimarkdown
brew install pandoc
brew install p7zip

brew install ack

# Control spotify from the command line - https://harishnarayanan.org/projects/shpotify/ - https://github.com/hnarayanan/shpotify
brew install shpotify

### install cask
### https://caskroom.github.io

brew install caskroom/cask/brew-cask
brew tap caskroom/versions

### install gui applications

brew cask install google-chrome
brew cask install firefox
brew cask install libreoffice
brew cask install adium
brew cask install atom
brew cask install calibre
brew cask install marp
brew cask install nvalt

# required for creating pdf with pandoc
brew cask install basictex

### this one requires manual installation
brew cask install oversight

### untested casks

#brew cask install dropbox
#brew cask install alfred
#brew cask install audacity
#brew cask install bartender
#brew cask install bettertouchtool
#brew cask install crashplan
#brew cask install filezilla
#brew cask install gpgtools
#brew cask install libreoffice
#brew cask install projectlibre
#brew cask install calibre
#brew cask install mp3gain-express
#brew cask install scroll-reverser
#brew cask install skype
#brew cask install textwrangler
#brew cask install the-unarchiver
#brew cask install vlc
#brew cask install transmission

### install some fonts using brew :)

brew tap caskroom/fonts
brew cask install font-source-code-pro # used for terminal and atom
brew cask install font-courier-prime

### install gems

gem update --system
gem update

gem install jekyll
gem install github-pages # unsure if this also will install jekyll
gem install bundler
bundler install
