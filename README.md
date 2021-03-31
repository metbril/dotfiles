# dotfiles

My personal dotfiles

## Installation

Clone and move into this repository:

```shell
git clone https://github.com/metbril/dotfiles ~/dotfiles
cd ~/dotfiles
```

## Usage

### Clean install

Run bootstrap script:

```shell
cd ~/dotfiles
bin/bootstrap
```

The bootstrap script will first install XCode command-line tools and Homebrew and then use Homebrew to install everything from the Brewfile.

### Install applications

```shell
brew bundle --file=~/dotfiles/
```

## Important

**.config/filezilla**

The Filezilla config contains login credentials and is not suitable to be added to this repo.

## Tips & Tricks

- [Brew Bundle Brewfile Tips](https://gist.github.com/ChristopherA/a579274536aab36ea9966f301ff14f3f)
- [macOS migrations with Brewfile](https://openfolder.sh/macos-migrations-with-brewfile)
