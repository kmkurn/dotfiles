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

# Prompt string configuration
if [ -f "$HOME/.bash_prompt" ]; then
    source "$HOME/.bash_prompt"
fi

# Local prompt string configuration
if [ -f "$HOME/.bash_prompt.local" ]; then
    source "$HOME/.bash_prompt.local"
fi

# Alias definitions
if [ -f "$HOME/.aliases" ]; then
    source "$HOME/.aliases"
fi

# Local alias definitions
if [ -f "$HOME/.aliases.local" ]; then
    source "$HOME/.aliases.local"
fi

# Set dircolors
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

# Check if Homebrew is installed
brew help > /dev/null 2>&1
HOMEBREW_INSTALLED="$?"

# Enable bash completion feature installed by Homebrew
if [ "$HOMEBREW_INSTALLED" -eq 0 -a -f "$(brew --prefix)/etc/bash_completion" ]; then
    source "$(brew --prefix)/etc/bash_completion"
fi

# Tab completion for conda
if [ -f "$HOME/miniconda3/bin/register-python-argcomplete" ]; then
    eval "$($HOME/miniconda3/bin/register-python-argcomplete conda)"
fi

# Set architecture flag
export ARCHFLAGS="-arch x86_64"

# Ensure brew-installed binaries take precedence
if [ "$HOMEBREW_INSTALLED" -eq 0 ]; then
    export PATH="$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH"
fi

# Prioritize GNU coreutils
if [ "$HOMEBREW_INSTALLED" -eq 0 -a -n "$(brew --prefix coreutils 2>/dev/null)" ]; then
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
    export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
fi

# Pip bash completion
pip help > /dev/null 2>&1
if [ "$?" -eq 0 ]; then
    eval "$(pip completion --bash)"
fi

# Check if Pyenv is installed
pyenv help > /dev/null 2>&1
PYENV_INSTALLED="$?"

# Pyenv settings
if [ "$PYENV_INSTALLED" -eq 0 ]; then
    eval "$(pyenv init -)"
fi

# Pyenv-virtualenv settings
if [ "$PYENV_INSTALLED" -eq 0 ]; then
    pyenv commands | grep -q virtualenv
    if [ "$?" -eq 0 ]; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi

# Jenv settings
jenv help > /dev/null 2>&1
if [ "$?" -eq 0 ]; then
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"
fi

# NVM settings
if [ "$HOMEBREW_INSTALLED" -eq 0 ]; then
    brew list | grep -q nvm
    if [ "$?" -eq 0 ]; then
        export NVM_DIR="$HOME/.nvm"
        source "$(brew --prefix nvm)/nvm.sh"
    fi
fi

# Local binary; used by Stackage
export PATH="$HOME/.local/bin:$PATH"

# Stack tool autocomplete
stack --help > /dev/null 2>&1
if [ "$?" -eq 0 ]; then
    eval "$(stack --bash-completion-script "$(which stack)")"
fi

# rbenv settings
rbenv --help > /dev/null 2>&1
if [ "$?" -eq 0 ]; then
    eval "$(rbenv init -)"
fi

# Print archey
archey --help > /dev/null 2>&1
if [ "$?" -eq 0 ]; then
    archey
fi

# Gruvbox vim colorscheme
if [ -f "$HOME/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh" ]; then
    source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette_osx.sh"
fi

# Local .bash_profile
if [ -f "$HOME/.bash_profile.local" ]; then
    source "$HOME/.bash_profile.local"
fi
