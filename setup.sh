#!/bin/bash

# change http to ssh
cd $HOME

mkdir $HOME/.config

DOT_DIR="dotfiles_coder"

# this file creates symbolic links for dotfiles.

SHELL_FILES=(
    .bashrc .bash_profile .bash_logout
    .profile
    .zshrc .zshenv .zprofile
    .tmux.conf
    .Xmodmap
)

CONFIG_FILES=(
    .gitconfig
)


for file in ${SHELL_FILES[@]}
do
    rm -rf $HOME/$file
    if [ -a $HOME/$file ]; then
        ln -s $HOME/$DOT_DIR/shell/$file $HOME/$file.dot
        echo "file exists, created .dot file: $file"
    else
        ln -s $HOME/$DOT_DIR/shell/$file $HOME/$file
        echo "made symbolic link: $file"
    fi
done

for file in ${CONFIG_FILES[@]}
do
    rm -rf $HOME/$file
    if [ -a $HOME/$file ]; then
        ln -s $HOME/$DOT_DIR/$file $HOME/$file.dot
        echo "file exists, created .dot file: $file"
    else
        ln -s $HOME/$DOT_DIR/$file $HOME/$file
        echo "made symbolic link: $file"
    fi

    # ln -s -f $HOME/dotfiles_mac/$file $HOME/$file  # force
done

# private
mkdir $HOME/private
touch $HOME/private/.zsh_history