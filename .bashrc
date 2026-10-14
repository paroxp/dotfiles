#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# asdf: put its shims first on PATH, as conf.d/asdf.fish does for fish
asdf_shims="${ASDF_DATA_DIR:-$HOME/.asdf}/shims"
case ":$PATH:" in
  *":$asdf_shims:"*) ;;
  *) export PATH="$asdf_shims:$PATH" ;;
esac
unset asdf_shims

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

# Offer to attach to a tmux session; see ~/.local/bin/tmux-pick.
# TMUX_PICKED stops shells started from this one from asking again.
if [ -z "$TMUX_PICKED" ] && [ -x "$HOME/.local/bin/tmux-pick" ]; then
  export TMUX_PICKED=1
  "$HOME/.local/bin/tmux-pick"
fi
