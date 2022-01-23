# Dotfiles

## Installation

Clone the directory and link some files.

```sh
git clone https://github.com/paroxp/dotfiles.git ~/.dot
```

## Linking files

Linking the files, seems like a better approach as oppose of copying the files
into our home directory. It gives us more control.

### Link base files

```sh
ln -sf ~/.dot/.zsh/.zshrc ~/.zshrc
ln -sf ~/.dot/.vimrc ~/.vimrc
ln -sf ~/.dot/.gitconfig ~/.gitconfig
ln -sf ~/.dot/.tmux.conf ~/.tmux.conf
ln -sf ~/.dot/.gnupg/gpg.conf ~/.gnuph/gpg.conf
ln -sf ~/.dot/.gnupg/gpg-agent.conf ~/.gnuph/gpg-agent.conf
```

### Link `.oh-my-zsh` theme

```sh
ln -sf ~/.dot/.zsh/themes/prompt.zsh-theme ~/.oh-my-zsh/themes/prompt.zsh-theme
```

