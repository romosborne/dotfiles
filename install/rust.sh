#!/usr/bin/env bash

if ! command -v cargo > /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  echo '. "$HOME/.cargo/env"' >> ~/.zshrc
else 
  ok "Already installed"
fi
