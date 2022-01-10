# My custom .bashrc file based on /usr/share/doc/bash/example/startup-files
# in the bash-doc package

# Copyright (c) Kemal Maulana
# Licensed under the MIT license
# See LICENSE to view the full license

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Homebrew for Linux
if [[ -d "$HOME/.linuxbrew" ]]; then
    eval "$($HOME/.linuxbrew/bin/brew shellenv)"
fi

# Sensible bash defaults
if [[ -f "$HOME/.sensible.bash" ]]; then
    source "$HOME/.sensible.bash"
fi

# Alias definitions
if [[ -f "$HOME/.aliases" ]]; then
    source "$HOME/.aliases"
fi

# Local alias definitions
if [[ -f "$HOME/.aliases.local" ]]; then
    source "$HOME/.aliases.local"
fi

# Set dircolors
if [[ -f "$HOME/.dircolors" ]]; then
    source "$HOME/.dircolors"
fi

# Color the output of 'man' command
# source: https://wiki.archlinux.org/index.php/Man_Page#Colored_man_pages
man() {
    env LESS_TERMCAP_mb="$(printf "\e[1;31m")" \
        LESS_TERMCAP_md="$(printf "\e[1;31m")" \
        LESS_TERMCAP_me="$(printf "\e[0m")" \
        LESS_TERMCAP_se="$(printf "\e[0m")" \
        LESS_TERMCAP_so="$(printf "\e[1;44;33m")" \
        LESS_TERMCAP_ue="$(printf "\e[0m")" \
        LESS_TERMCAP_us="$(printf "\e[1;32m")" \
        man "$@"
}

# Use Vim as the default text editor (useful when using Git)
export EDITOR=vim

# Disable flow control. This enables Ctrl+s to open file in horizontal split
# when using Command-T in Vim
stty -ixon

# Local binary; used by pipx, etc.
export PATH="$HOME/.local/bin:$PATH"

# Prompt string configuration
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if hash powerline-shell 2>/dev/null; then
    if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
    fi
fi

if hash bat 2>/dev/null; then
    export BAT_THEME="Solarized (dark)"
fi

if [[ -f "$HOME/.fzf.bash" ]]; then
    source "$HOME/.fzf.bash"
fi

if hash fzf 2>/dev/null && hash fd 2>/dev/null; then
    _fzf_compgen_path() {
        fd --follow . "$1"
    }

    _fzf_compgen_dir() {
        fd --type d --follow . "$1"
    }
fi

# Local .bashrc
if [[ -f "$HOME/.bashrc.local" ]]; then
    source "$HOME/.bashrc.local"
fi
