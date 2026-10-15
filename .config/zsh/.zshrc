HISTFILE=~/.config/zsh/.histfile
HISTSIZE=50000
SAVEHIST=$HISTSIZE

# Share history between running shells as commands run; drop duplicates and
# lines starting with a space
setopt EXTENDED_HISTORY SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS
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
