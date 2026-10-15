HISTFILE=~/.config/zsh/.histfile
HISTSIZE=1000
SAVEHIST=$HISTSIZE

setopt EXTENDED_HISTORY
setopt autocd
autoload -U compinit; compinit

eval "$(starship init zsh)"
source <(fzf --zsh)

set -o vi
bindkey -v '^?' backward-delete-char

# Alt+Left / Alt+Right move a word back / forward, as in fish, bash and nvim
for keymap in viins vicmd; do
  bindkey -M $keymap '^[[1;3D' backward-word
  bindkey -M $keymap '^[[1;3C' emacs-forward-word
done
unset keymap

# Shared with bash: PATH, GnuPG, aliases, environment, tmux picker
source ~/.config/shell/common.sh
