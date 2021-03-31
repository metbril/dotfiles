#!/usr/bin/env zsh

# https://shreevatsa.wordpress.com/2008/03/30/zshbash-startup-files-loading-order-bashrc-zshrc-etc/

for file in ~/.{path,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

export EDITOR=nano
export VISUAL="$EDITOR"

# homebrew python
export PATH=/usr/local/opt/python@3.9/libexec/bin:$PATH

# iterm2 integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"