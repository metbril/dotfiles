# Main Brewfile
# Robert van Bregt

tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/cask-drivers"
tap "homebrew/cask-fonts"
tap "homebrew/cask-versions"
tap "homebrew/core"

tap "buo/cask-upgrade"
tap "rajiv/fastmate"

brew "mas"
brew "svn"

# --- Formulae ---

# required for dotfiles
brew "stow"

# dev
brew "python3"
brew "isort"
brew "black"
brew "yamllint"

# brew "bitwarden-cli"
# brew "coreutils"
# brew "exiftool"
brew "hugo"
# brew "imagemagick"
# brew "imageoptim-cli"
# brew "multimarkdown"
# brew "pandoc"
# brew "rename"
# brew "terminal-notifier"
# brew "tmux"

# --- Fonts ---

cask "font-fira-mono"
cask "font-fira-code"
cask "font-fira-code-nerd-font"
cask "font-ia-writer-duo"
cask "font-ia-writer-mono"
cask "font-ia-writer-quattro"
cask "font-ibm-plex-mono"  # requires svn package
cask "font-oswald"

# --- Mac App Store
# Place these before casks, to prefer MAS if accidentally listed in both

mas "Amphetamine", id: 937984704
mas "Bitwarden", id: 1352778147
mas "BBedit", id: 404009241
mas "Garmin BaseCamp", id: 411052274
mas "Home Assistant", id: 1099568401
mas "Things", id: 904280696

# --- Casks / Applications ---

# cask "adobe-digital-editions"
cask "alfred"
cask "appcleaner"
# cask "balenaetcher"
cask "bartender"
# cask "basictex"  # to create pdf with pandoc
cask "backblaze"
cask "bettertouchtool"
cask "calibre"
cask "coconutbattery"
cask "cryptomator"
# cask "cyberduck"
# cask "devonthink"
# cask "digikam"
cask "fastmate"
cask "firefox", args: { language: "nl" }
cask "hazel"
# cask "imageoptim"
# cask "iterm2"
# cask "keyboard-maestro"  # disabled; using an older version
# cask "keyboardcleantool"
cask "libreoffice"
cask "little-snitch"
cask "namechanger"
cask "nvalt"
cask "obsidian"
cask "omnidisksweeper"
cask "rectangle"
cask "scroll-reverser"
cask "signal"
cask "spotify"
cask "sync"
# cask "thunderbird"
# cask "ubersicht"
cask "visual-studio-code"
cask "vlc"
# cask "zotero"

# requires sudo
cask "private-internet-access"

# requires manual install afterwards
cask "libreoffice-language-pack" , args: { language: "nl" }

# --- Drivers ---

cask "garmin-express"
# cask "jabra-direct"
# cask "logitech-camera-settings"  # webcam
# cask "logitech-options"          # mouse / keyboard
# cask "logitech-unifying"         # mouse / keyboard
# cask "samsung-portable-ssd-t5"
# cask "sonos"
# cask "yubico-yubikey-personalization-gui"
