#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

eval "$(starship init bash)"
source <(fzf --bash)

export GPG_TTY=$(tty)
eval "$(gpg-agent --daemon)"

alias config="git --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME}"
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias ls='ls --color=tty --human-readable'
alias ping='ping -c 5'

export EDITOR="nvim"
export LESS="-R"

PS1='[\u@\h \W]\$ '
