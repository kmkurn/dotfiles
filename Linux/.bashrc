# My custom .bashrc file based on /usr/share/doc/bash/example/startup-files
# in the bash-doc package

# Copyright (c) 2014 Kemal Maulana
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

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Load dircolors configuration
if [ -f ~/.dircolors ]; then
    . ~/.dircolors
fi

# Load prompt configuration in ~/.bash_prompt
if [ -f ~/.bash_prompt ]; then
    . ~/.bash_prompt
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

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

# Use GVim as the default GUI text editor
export VISUAL=gvim

# Use Vim as the default text editor (useful when using Git)
export EDITOR=vim

# Disable flow control. This enables Ctrl+s to open file in horizontal split
# when using Command-T in Vim
stty -ixon

# Tab completion for conda
[ -f "$HOME/miniconda3/bin/register-python-argcomplete" ] && eval "$($HOME/miniconda3/bin/register-python-argcomplete conda)"

# DO NOT use graphical ssh
unset SSH_ASKPASS

# Add redis bin directory to PATH
export PATH="/opt/redis/bin:$PATH"

# Add arcanist bin directory to PATH
export PATH="$HOME/Software/arcanist/arcanist/bin:$PATH"

# added by travis gem
[ -f /home/kemal/.travis/travis.sh ] && source /home/kemal/.travis/travis.sh
