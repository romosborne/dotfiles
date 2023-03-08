#!/usr/bin/env bash

if ! command -v docker > /dev/null; then
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  rm get-docker.sh
  getent group docker || sudo groupadd docker
  sudo usermod -aG docker $USER
  newgrp docker
  sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
  sudo chmod g+rwx "$HOME/.docker" -R
else 
  ok "Already installed"
fi
