#!/bin/bash

# Ask Y/n
function ask() {
  read -p "$1 (Y/n)" resp
  
  if [ -z "$resp" ]; then
    response_lc="y" # empty is Yes
  else
    response_lc=$(echo "$resp" | tr '[:upper:]' '[:lower:]') # case insensitive
  fi

  [ "$response_lc" = "y" ]
}

if ask "Link .vimrc?"; then
  ln -s $(realpath "vimrc") ~/.vimrc
fi

if ask "Link .zshrc?"; then
  ln -s $(realpath "zshrc") ~/.zshrc
fi

if ask "Link .p10k?"; then
  ln -s $(realpath "p10k.zsh") ~/.p10k.zsh
fi

if ask "Link neovim?"; then
  if ! [ -d ~/.config/nvim ]; then
    mkdir -p -m 755 ~/.config/nvim
  fi
  ln -Ffs $(realpath "nvim") ~/.config/
fi
