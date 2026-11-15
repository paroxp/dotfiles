# zsh reads its startup files from $ZDOTDIR; keep them with the rest of the
# dotfiles. On macOS, where zsh is the login shell, this is what makes
# ~/.config/zsh/.zshrc and .zprofile get read at all.
ZDOTDIR=$HOME/.config/zsh
export ZDOTDIR
