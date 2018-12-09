# My custom .bashrc based on /usr/share/doc/bash/example/startup-files
# in the bash-doc package

# Mac OS X with iTerm2

# Copyright (c) Kemal Maulana
# Licensed under the MIT license
# See LICENSE to view the full license

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Set locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Set architecture flag
export ARCHFLAGS="-arch x86_64"

# Sensible bash defaults
if [[ -e "$HOME/.sensible.bash" ]]; then
    source "$HOME/.sensible.bash"
fi

# Add targets for cd for fast access (thanks bash-sensible!)
CDPATH=".:$HOME/projects"

# Prompt string configuration
if [[ -e "$HOME/.bash-powerline.sh" ]]; then
    source "$HOME/.bash-powerline.sh"
fi

# Alias definitions
if [[ -e "$HOME/.aliases" ]]; then
    source "$HOME/.aliases"
fi

# Local alias definitions
if [[ -e "$HOME/.aliases.local" ]]; then
    source "$HOME/.aliases.local"
fi

# Set dircolors
if [[ -e "$HOME/.dircolors" ]]; then
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

# Ensure brew-installed binaries take precedence
if brew help > /dev/null 2>&1; then
    export PATH="$(brew --prefix)/bin:$(brew --prefix)/sbin:$PATH"
fi

# Prioritize GNU coreutils
if brew help > /dev/null 2>&1 && [[ -n "$(brew --prefix coreutils 2>/dev/null)" ]]; then
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
    export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"
fi

# Enable bash completion feature installed by Homebrew
if brew help > /dev/null 2>&1 && [[ -e "$(brew --prefix)/etc/bash_completion" ]]; then
    source "$(brew --prefix)/etc/bash_completion"
fi

# Local binary; used by Stackage, pipx, etc.
export PATH="$HOME/.local/bin:$PATH"

# Conda binary
if [[ -d "$HOME/miniconda3/bin" ]]; then
    export PATH="$HOME/miniconda3/bin:$PATH"
fi

# Pyenv settings
if pyenv help > /dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# Jenv settings
if jenv help > /dev/null 2>&1; then
    export PATH="$HOME/.jenv/bin:$PATH"
    eval "$(jenv init -)"
fi

# NVM settings
if [[ -e $HOME/.nvm/nvm.sh ]]; then
    export NVM_DIR="$HOME/.nvm"
    source "$NVM_DIR/nvm.sh"
    source "$NVM_DIR/bash_completion"
fi

# rbenv settings
if rbenv --help > /dev/null 2>&1; then
    eval "$(rbenv init -)"
fi

# Stack tool autocomplete
if stack --help > /dev/null 2>&1; then
    eval "$(stack --bash-completion-script "$(which stack)")"
fi

# Set jar path for languagetool
if brew help > /dev/null 2>&1 && [[ -n "$(brew --prefix languagetool 2>/dev/null)" ]]; then
    export LANGTOOL_JAR_PATH="$(brew --prefix languagetool)/libexec/languagetool-commandline.jar"
fi

# Print archey
if archey --help > /dev/null 2>&1; then
    archey
fi

# Local .bashrc
if [[ -e "$HOME/.bashrc.local" ]]; then
    source "$HOME/.bashrc.local"
fi
