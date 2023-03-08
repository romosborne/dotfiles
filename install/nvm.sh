#!/usr/bin/env bash

if ! command -v nvm > /dev/null; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
else 
  ok "Already installed"
fi
