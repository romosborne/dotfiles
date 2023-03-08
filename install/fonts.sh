#!/bin/bash

if [[ $(uname) == 'Darwin' ]]; then
  # MacOS
  font_dir="$HOME/Library/Fonts"
else
  # Linux
  font_dir="$HOME/.local/share/fonts"
  mkdir -p $font_dir
fi

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip
unzip FiraCode.zip -d $font_dir
rm FiraCode.zip

# Reset font cache on Linux
if command -v fc-cache @>/dev/null ; then
    echo "Resetting font cache, this may take a moment..."
    fc-cache -f $font_dir
fi

echo "All Powerline fonts installed to $font_dir"