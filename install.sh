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
		echo -n "File '$HOME/$file' exists. Delete file? (Y/n) "
		read opt
		if [ "$opt" = "n" ]; then
			mv $HOME/$file $HOME/$file.old
			echo "Renamed '$HOME/$file' into '$HOME/$file.old'"
		else
			rm $HOME/$file
			echo "'$HOME/$file' deleted"
		fi
	fi

	ln -s $PWD/$file $HOME/$file
}

# Catch interrupt signal (usually by pressing CTRL-C)
trap 'echo "Interrupted by user. Aborting."; exit 1;' INT

# Use all dotfiles
for dotfile in $DOTFILES; do
	use $dotfile
done

echo "Dotfiles has been installed! Execute 'source ~/.bashrc' to apply changes."
echo "To get the latest update of dotfiles, simply execute 'git pull' in this directory. Enjoy!"

exit
