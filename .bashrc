#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Fallback prompt for machines without starship
PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"
source <(fzf --bash)

# Shared with zsh: PATH, GnuPG, aliases, environment, tmux picker
source ~/.config/shell/common.sh
