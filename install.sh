#!/bin/bash

# Dotfiles installation script
# Copyright (c) 2013 Kemal Maulana
# Licensed under the MIT license
# See LICENSE to view the full license

DOTFILES=".aliases .bash_prompt .bashrc .vimrc .gitconfig .i3status.conf"

# Create symlinks to dotfiles in $HOME directory
use() {
    file="$1"
    # Check if file already existed. If yes, then prompt user whether to
    # delete or rename it with .old extension
    if [ -f "$HOME/$file" ]; then
        echo -n "File '$HOME/$file' exists. Delete file? (Y/n) "
        read opt
        if [ "$opt" = "n" ]; then
            mv "$HOME/$file" "$HOME/$file.old"
            echo "Renamed '$HOME/$file' into '$HOME/$file.old'"
        else
            rm "$HOME/$file"
            echo "'$HOME/$file' deleted"
        fi
    fi
    ln -s `realpath "$file"` "$HOME/$file"
}

# Catch interrupt signal (usually by pressing CTRL-C)
trap 'echo "Interrupted by user. Aborting."; exit 1;' INT

# Use all dotfiles
for dotfile in $DOTFILES; do
    use $dotfile
done

echo "Dotfiles has been installed! Restart your shell to apply changes."

exit
