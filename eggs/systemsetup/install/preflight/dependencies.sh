#!/usr/bin/env bash

if [[ -z "$(yaolk --version 2>/dev/null)" ]]; then
  printf "\e[33mYolk not installed!\e[0m\nInstalling now..."
  yay -S yolk
fi
if [[ -z "$(gsum --version 2>/dev/null)" ]]; then
  printf "\e[33mGum not installed!\e[0m\nInstalling now..."
  sudo pacman -S gum
fi
