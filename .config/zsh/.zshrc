HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=$HISTSIZE

setopt EXTENDED_HISTORY
setopt autocd
autoload -U compinit; compinit

eval "$(starship init zsh)"
source <(fzf --zsh)

export GPG_TTY=$(tty)
eval "$(gpg-agent --daemon)"

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

