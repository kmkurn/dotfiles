#!/bin/bash

# Rename existing file with .old extension and copy dotfiles to home dir
use() {
	file="$1"
	if [ -f ~/"$file" ]; then
		mv ~/"$file" ~/"$file".old
	fi
	cp "$file" ~/"$file"
}

# Use .bash_aliases
use .bash_aliases

# Copy .bash_ps1
cp .bash_ps1 ~/.bash_ps1

# Copy .vimrc
use .vimrc

# Use .bashrc and apply it to current shell
use .bashrc
source ~/.bashrc
