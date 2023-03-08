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

  bot "Now for the brew casks"
  brew doctor
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

fi

bot "OK!  Done!"