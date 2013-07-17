#!/bin/bash

# Dotfiles installation script
# Author: Kemal Maulana <kemskems12@gmail.com>

DOTFILES=".bash_aliases .bash_ps1 .bashrc .vimrc"
PWD=`pwd`

# Rename existing file with .old extension
# and create a symbolic link in home directory to dotfiles
# you can then update the dotfiles by simply executing 'git pull'
use() {
	file=$1

	if [ -f $HOME/$file ]; then
		mv $HOME/$file $HOME/$file.old
	fi
	ln -s $PWD/$file $HOME/$file
}

# Use all dotfiles
for dotfile in $DOTFILES; do
	use $dotfile
done

echo "Dotfiles has been installed!"
echo "To get the latest update of dotfiles, simply execute 'git pull'"
exit
