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
ln -s ~/.dot/.zshrc ~/.zshrc
ln -s ~/.dot/.vimrc ~/.vimrc
ln -s ~/.dot/.gitconfig ~/.gitconfig
```

### Link `.oh-my-zsh` theme

```sh
ln -s ~/.dot/.oh-my-zsh/themes/rafal.zsh-theme ~/.oh-my-zsh/themes/rafal.zsh-theme
```

This is greatly based on
[Honukai](https://github.com/oskarkrawczyk/honukai-iterm-zsh) theme, with minor
changes to suit my needs in a better way. Credit is due :)

### Copy optional terminal config files

We're not linking them. These aren't going to change so often...

#### Terminator

```sh
mkdir -p ~/.config/terminator
cp -rf ~/.dot/config.terminator "~/.config/terminator/config"
```

#### Konsole

```sh
mkdir -p ~/.local/share/konsole
cp -rf ~/.dot/konsole/Honukai.* "~/.local/share/konsole"
```

