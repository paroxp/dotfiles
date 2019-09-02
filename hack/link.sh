#!/usr/bin/env bash

set -eu

OS="${OS:-linux}"

function link {
  if [ "${2:-false}" == "true" ]; then
    mkdir -p "${HOME}/${1}"
  fi

  ln -sf "${HOME}/.dot/${1}" "${HOME}/${1}"
}

if [ "${OS}" == "linux" ]; then
  link ".config/compton" true
  link ".config/dunst" true
  link ".config/gtk-3.0" true
  link ".config/i3" true
  link ".config/polybar" true
  link ".config/rofi" true
  link ".config/termite" true
  link ".config/xfce4" true

  link ".gtkrc-2.0"
  link ".gtkrc-2.0.mine"
  link ".Xresources"
fi

link ".gnupg" true
link ".gemrc"
link ".gitconfig"
link ".vimrc"
link ".zshrc"

# mkdir -p ${HOME}/.oh-my-zsh/themes/
# link .oh-my-zsh/themes/rafal.zsh-theme
