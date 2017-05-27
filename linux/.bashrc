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

# Set locale
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Sensible bash defaults
if [ -f "$HOME/.sensible.bash" ]; then
    source "$HOME/.sensible.bash"
fi

# Prompt string configuration
if [ -f "$HOME/.bash-powerline.sh" ]; then
    source "$HOME/.bash-powerline.sh"
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

# Make less more friendly for non-text input files, see lesspipe(1)
if [ -x /usr/bin/lesspipe ]; then
    eval "$(SHELL=/bin/sh lesspipe)"
fi

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
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

# Tab completion for conda
if [ -f "$HOME/miniconda3/bin/register-python-argcomplete" ]; then
    eval "$($HOME/miniconda3/bin/register-python-argcomplete conda)"
fi

# DO NOT use graphical ssh
unset SSH_ASKPASS

# Redis settings
if [ -d "/opt/redis/bin" ]; then
    export PATH="/opt/redis/bin:$PATH"
fi

# Arcanist settings
if [ -d "$HOME/arcanist/arcanist/bin" ]; then
    export PATH="$HOME/arcanist/arcanist/bin:$PATH"
fi

# Travis CI settings
if [ -f "$HOME/.travis/travis.sh" ]; then
    source "$HOME/.travis/travis.sh"
fi

# NVM settings
if [ -f "$HOME/.nvm/nvm.sh" ]; then
  source ~/.nvm/nvm.sh
fi

# Local .bashrc
if [ -f "$HOME/.bashrc.local" ]; then
    source "$HOME/.bashrc.local"
fi
