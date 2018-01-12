# Dotfiles

## Requirements

- git
- vim
- zsh
- ohmyz.sh

## Installation

Not much todo here. Simply clone the directory and link some files!

```sh
git clone git@github.com:paroxp/dotfiles.git ~/.dot
```

## Linking files

Linking the files, seems like a better approach as oppose of copying the files
into our home directory. It gives us more control.

### Link base files

```sh
ln -sf ~/.dot/.zshrc ~/.zshrc
ln -sf ~/.dot/.vimrc ~/.vimrc
ln -sf ~/.dot/.gitconfig ~/.gitconfig
```

### Link `.oh-my-zsh` theme

```sh
ln -sf ~/.dot/.oh-my-zsh/themes/rafal.zsh-theme ~/.oh-my-zsh/themes/rafal.zsh-theme
```

This is greatly based on
[Honukai](https://github.com/oskarkrawczyk/honukai-iterm-zsh) theme, with minor
changes to suit my needs in a better way. Credit is due :)

#### Terminator

```sh
ln -sf ~/.dot/.config/terminator ~/.config/terminator
```

#### Konsole

```sh
ln -sf ~/.dot/.local/share/konsole ~/.local/share/konsole
```

