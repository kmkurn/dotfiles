# My custom .bash_profile based on /usr/share/doc/bash/example/startup-files
# in the bash-doc package

# Mac OS X with iTerm2

# Copyright (c) 2014-2015 Kemal Maulana
# Licensed under the MIT license
# See LICENSE to view the full license

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# No limit on history size but do limit the history file size
HISTSIZE=""
HISTFILESIZE=2000

# Check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Load prompt string configuration
if [ -f "$HOME/.bash_prompt" ]; then
    source "$HOME/.bash_prompt"
fi

# Alias definitions
if [ -f "$HOME/.aliases" ]; then
    source "$HOME/.aliases"
fi

# Set Solarized dircolors
if [ -f "$HOME/.dircolors" ]; then
    source "$HOME/.dircolors"
fi

# Color the output of 'man' command
# source: https://wiki.archlinux.org/index.php/Man_Page#Colored_man_pages
man() {
    env LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

# Use Vim as the default text editor (useful when using Git)
export EDITOR=vim

# Disable flow control. This enables Ctrl+s to open file in horizontal split
# when using Command-T in Vim
stty -ixon

# Enable bash completion feature installed by Homebrew
hash brew 2>/dev/null
if [ "$?" -eq 0 -a -f "$(brew --prefix)/etc/bash_completion" ]; then
    source "$(brew --prefix)/etc/bash_completion"
fi

# Tab completion for conda
if [ -f "$HOME/miniconda3/bin/register-python-argcomplete" ]; then
    eval "$($HOME/miniconda3/bin/register-python-argcomplete conda)"
fi

# Set architecture flag
export ARCHFLAGS="-arch x86_64"

# Ensure brew-installed binaries take precedence
hash brew 2>/dev/null
if [ "$?" -eq 0 ]; then
    export PATH="$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH"
fi

# Prioritize GNU coreutils
hash brew 2>/dev/null
if [ "$?" -eq 0 -a -n "$(brew --prefix coreutils 2>/dev/null)" ]; then
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
    export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
fi

# Pip bash completion
hash pip 2>/dev/null
if [ "$?" -eq 0 ]; then
    eval "$(pip completion --bash)"
fi

# Pyenv settings
hash pyenv 2>/dev/null
if [ "$?" -eq 0 ]; then
    eval "$(pyenv init -)"
fi

# Pyenv-virtualenv settings
hash pyenv 2>/dev/null && pyenv commands | grep -q virtualenv
if [ "$?" -eq 0 ]; then
    eval "$(pyenv virtualenv-init -)"
fi

# Jenv settings
export PATH="$HOME/.jenv/bin:$PATH"
hash jenv 2>/dev/null
if [ "$?" -eq 0 ]; then
    eval "$(jenv init -)"
fi

# NVM settings
export NVM_DIR="$HOME/.nvm"
hash brew 2>/dev/null
if [ "$?" -eq 0 ]; then
    source "$(brew --prefix nvm)/nvm.sh"
fi

# Cabal-installed binary
export PATH="$HOME/Library/Haskell/bin:$PATH"

# Print archey
hash archey 2>/dev/null
if [ "$?" -eq 0 ]; then
    archey
fi
