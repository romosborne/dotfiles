#!/usr/bin/env bash

if [ ! -d ~/.config/nvim ]; then
  git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim || true
fi