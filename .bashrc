#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

eval "$(starship init bash)"
source <(fzf --bash)

# GnuPG / YubiKey. See ~/.github/YUBIKEY.md.
if command -v gpgconf >/dev/null 2>&1; then
  export GPG_TTY=$(tty)
  if [ -z "$SSH_CONNECTION" ] || [ -z "$SSH_AUTH_SOCK" ]; then
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  fi
  [ -n "$SSH_CONNECTION" ] && export PINENTRY_USER_DATA=tty
  gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
fi

alias config="git --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME}"
alias grep='grep --color=auto'
alias ip='ip --color=auto'
alias ls='ls --color=tty --human-readable'
alias ping='ping -c 5'

export EDITOR="nvim"
export LESS="-R"
export FZF_DEFAULT_OPTS="--color=16,prompt:blue,pointer:yellow,hl:yellow,hl+:yellow,marker:green"

PS1='[\u@\h \W]\$ '
