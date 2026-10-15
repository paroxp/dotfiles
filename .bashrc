#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History: keep plenty, skip duplicates and lines starting with a space, and
# append on exit instead of overwriting what other shells saved
HISTSIZE=50000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend

# Fallback prompt for machines without starship
PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"
source <(fzf --bash)

# Shared with zsh: PATH, GnuPG, aliases, environment, tmux picker
source ~/.config/shell/common.sh
