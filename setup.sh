#!/usr/bin/env bash

set -e 

. ./lib_sh/echos.sh

bot "Hey!"

if [ $(uname -s) = "Linux" ]; then
  bot "OK, time to install some general packages"
  sudo apt update -y
  sudo apt install -y \
    curl wget git apt-transport-https ca-certificates build-essential software-properties-common unzip zsh
  ok

  bot "Now let's do the more awkward packages"
  for fullfilename in ./install/*.sh; do
    [ -e "$fullfilename" ] || continue
    filename=$(basename -- "$fullfilename")
    package="${filename%.*}"
    action "installing ${package}"
    . "$fullfilename"
  done

  bot "Time for the brew packages"
  brew doctor
  while IFS="" read -r p || [ -n "$p" ]
  do
    start_install "brew install $p"
    if ! brew list "$p" > /dev/null 2>&1; then
      brew install "$p"
      done_install "done"
    else 
      done_install "already installed"
    fi
  done < brew.txt

  bot "Post install stuff"
  for fullfilename in ./postinstall/*.sh; do
    [ -e "$fullfilename" ] || continue
    filename=$(basename -- "$fullfilename")
    package="${filename%.*}"
    action "installing ${package}"
    . "$fullfilename"
  done
fi

if [ $(uname -s) = "Darwin" ]; then
  bot "Time for the brew packages"
  # brew doctor
  while IFS="" read -r p || [ -n "$p" ]
  do
    start_install "brew install $p"
    if ! brew list "$p" > /dev/null 2>&1; then
      brew install "$p"
      done_install "done"
    else 
      done_install "already installed"
    fi
  done < brew.txt

  bot "Now for the brew casks"
  # brew doctor
  brew tap homebrew/cask-fonts
  while IFS="" read -r p || [ -n "$p" ]
  do
    start_install "brew install --cask $p"
    if ! brew list "$p" > /dev/null 2>&1; then
      brew install --cask "$p"
      done_install "done"
    else 
      done_install "already installed"
    fi
  done < casks.txt

  bot "Post install stuff"
  for fullfilename in ./postinstall/*.sh; do
    [ -e "$fullfilename" ] || continue
    filename=$(basename -- "$fullfilename")
    package="${filename%.*}"
    action "installing ${package}"
    . "$fullfilename"
  done
fi

bot "Dotfiles Setup"
read -r -p "symlink ./homedir/* files in ~/ (these are the dotfiles)? [y|N] " response
if [[ $response =~ (y|yes|Y) ]]; then
  bot "creating symlinks for project dotfiles..."
  pushd homedir > /dev/null 2>&1
  now=$(date +"%Y.%m.%d.%H.%M.%S")

  for file in .*; do
    if [[ $file == "." || $file == ".." ]]; then
      continue
    fi
    running "~/$file"
    # if the file exists:
    if [[ -e ~/$file ]]; then
        mkdir -p ~/.dotfiles_backup/$now
        mv ~/$file ~/.dotfiles_backup/$now/$file
        echo "backup saved as ~/.dotfiles_backup/$now/$file"
    fi
    # symlink might still exist
    unlink ~/$file > /dev/null 2>&1
    # create the link
    ln -s ~/.dotfiles/homedir/$file ~/$file
    echo -en '\tlinked';ok
  done

  popd > /dev/null 2>&1
fi

bot "OK!  Done!"

zsh