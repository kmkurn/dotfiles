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

# Sensible bash defaults
if [[ -e "$HOME/.sensible.bash" ]]; then
    source "$HOME/.sensible.bash"
fi

# Add targets for cd for fast access (thanks bash-sensible!)
CDPATH=".:$HOME/projects"

# Set dircolors
if [[ -e "$HOME/.dircolors" ]]; then
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

if ! hash brew 2>/dev/null; then
    echo "homebrew isn't installed" >&2
fi

##### Set environment variables #####

export PATH
export MANPATH

# Prepend to PATH if not there yet
# Src: https://superuser.com/a/753948
prepend_path() {
    for ((i=$#; i>0; i--));
    do
        ARG=${!i}
        if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
            PATH="$ARG${PATH:+":$PATH"}"
        fi
    done
}

# Similar to prepend_path but for MANPATH
prepend_manpath() {
    for ((i=$#; i>0; i--));
    do
        ARG=${!i}
        if [ -d "$ARG" ] && [[ ":$MANPATH:" != *":$ARG:"* ]]; then
            MANPATH="$ARG${MANPATH:+":$MANPATH"}"
        fi
    done
}

# Ensure brew-installed binaries take precedence
if hash brew 2>/dev/null; then
    prepend_path "$(brew --prefix)/bin" "$(brew --prefix)/sbin"
fi

# Prioritize GNU coreutils
if hash brew 2>/dev/null && [[ -n "$(brew --prefix coreutils 2>/dev/null)" ]]; then
    prepend_path "$(brew --prefix coreutils)/libexec/gnubin"
    prepend_manpath "$(brew --prefix coreutils)/libexec/gnuman"
else
    echo "brew coreutils isn't installed" >&2
fi

# Enable bash completion feature installed by Homebrew
if hash brew 2>/dev/null && [[ -e "$(brew --prefix)/etc/bash_completion" ]]; then
    source "$(brew --prefix)/etc/bash_completion"
else
    echo "brew bash completion isn't installed" >&2
fi

# Local binary; used by pipx, etc.
prepend_path "$HOME/.local/bin"

# Setup conda
if [[ -d "$HOME/miniconda3" ]]; then
    source "$HOME/miniconda3/etc/profile.d/conda.sh"
fi

# Pyenv settings
if hash pyenv 2>/dev/null; then
    PYENV_ROOT="$HOME/.pyenv"
    export PYENV_ROOT
    prepend_path "$PYENV_ROOT/bin"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

# Prompt string configuration
_update_ps1() {
    PS1=$(powerline-shell $?)
}

if hash powerline-shell 2>/dev/null; then
    if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
    fi
else
    echo "powerline-shell isn't installed" >&2
fi

# Set jar path for languagetool
if hash brew 2>/dev/null && [[ -n "$(brew --prefix languagetool 2>/dev/null)" ]]; then
    LANGTOOL_JAR_PATH="$(brew --prefix languagetool)/libexec/languagetool-commandline.jar"
    export LANGTOOL_JAR_PATH
fi

if hash bat 2>/dev/null; then
    export BAT_THEME="Solarized (dark)"
else
    echo "bat isn't installed" >&2
fi

# Setup fzf bash completion
if [[ -f "$HOME/.fzf.bash" ]]; then
    source "$HOME/.fzf.bash"
else
    echo "fzf bash completion isn't installed" >&2
fi

if hash fd 2>/dev/null; then
    _fzf_compgen_path() {
        fd --follow . "$1"
    }

    _fzf_compgen_dir() {
        fd --type d --follow . "$1"
    }
else
    echo "fd isn't installed" >&2
fi

if hash zoxide 2>/dev/null; then
    eval "$(zoxide init bash)"
else
    echo "zoxide isn't installed"
fi

if [[ -d "$HOME/softwares/srilm/bin" ]]; then
    srilm_home="$HOME/softwares/srilm"
    prepend_path "$srilm_home/bin" "$srilm_home/bin/macosx"
    prepend_manpath "$srilm_home/man"
fi

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

##### Aliases/Functions #####

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

if hash exa 2>/dev/null; then
    alias ls='exa -F'
    alias ll='exa -lF'
    alias la='exa -alF'
    alias lha='exa -alF'
    alias tree='exa -T'
else
    echo "exa isn't installed" >&2
    if hash brew 2>/dev/null && brew ls --versions coreutils > /dev/null; then
        alias ls='gls --color=auto'
        alias ll='gls -lhF --color=auto'
        alias lha='gls -alhF --color=auto'
    else
        alias ls='ls -G'
        alias ll='ls -lhFG'
        alias lha='ls -alhFG'
    fi
fi

if hash brew 2>/dev/null && brew ls --versions htop-osx > /dev/null; then
    alias htop='sudo htop'
else
    echo "brew htop isn't installed" >&2
fi

switch_theme() {
    target="$1"
    source=dark

    if [[ $# -lt 1 ]]; then
        echo "Usage: switch_theme [dark/light]"
        return 1
    fi
    if [[ "$target" = dark ]]; then
        source=light
    fi

    # update dircolors
    dircolors_solarized="$HOME/projects/dotfiles/dircolors-solarized"
    if [[ -f "$dircolors_solarized/dircolors.ansi-$target" ]]; then
        dircolors "$dircolors_solarized/dircolors.ansi-$target" >| "$HOME/.dircolors"
        source "$HOME/.dircolors"
    else
        echo "dircolors-solarized not found; not setting dircolors to ANSI $target" >&2
    fi

    # update powerline-shell theme
    powerline_conf="$HOME/.config/powerline-shell/config.json"
    if [[ -f "$powerline_conf" ]]; then
        sed -i "" "/theme/s/_$source/_$target/" "$powerline_conf"
    else
        echo "powerline-shell config not found; not changing powerline theme" >&2
    fi
}

# Local .bashrc
if [[ -e "$HOME/.bashrc.local" ]]; then
    source "$HOME/.bashrc.local"
fi
