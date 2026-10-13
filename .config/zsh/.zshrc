HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=$HISTSIZE

setopt EXTENDED_HISTORY
setopt autocd
autoload -U compinit; compinit

eval "$(starship init zsh)"
source <(fzf --zsh)

# GnuPG / YubiKey. See ~/.github/YUBIKEY.md.
if command -v gpgconf >/dev/null 2>&1; then
  export GPG_TTY=$(tty)
  if [ -z "$SSH_CONNECTION" ] || [ -z "$SSH_AUTH_SOCK" ]; then
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  fi
  [ -n "$SSH_CONNECTION" ] && export PINENTRY_USER_DATA=tty
  gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
fi

bindkey -e
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

set -o vi
bindkey -v '^?' backward-delete-char

alias -- config="git --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME}"
alias -- grep='grep --color=auto'
alias -- ip='ip --color=auto'
alias -- ls='ls --color=tty --human-readable'
alias -- ping='ping -c 5'

export EDITOR="nvim"
export LESS="-R"

