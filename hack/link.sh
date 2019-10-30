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
  link ".config/compton"
  link ".config/dunst"
  link ".config/gtk-3.0"
  link ".config/i3"
  link ".config/polybar"
  link ".config/rofi"
  link ".config/termite"
  link ".config/xfce4"
  link ".local/share/konsole"

  link ".gtkrc-2.0"
  link ".gtkrc-2.0.mine"
  link ".Xresources"
fi

link ".gnupg" true
link ".gemrc"
link ".gitconfig"
link ".vimrc"

ln -sf "${HOME}/.dot/.zsh/.zshrc" "${HOME}/.zshrc"
ln -sf "${HOME}/.dot/.tmux.conf" "${HOME}/.tmux.conf"
