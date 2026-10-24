# dotfiles

My configuration files, tracked in a bare Git repository at `~/.dotfiles` with
`$HOME` as the work tree. No symlinks and no extra tooling: files live where
programs expect them, and a `config` command is `git` pointed at that
repository.

The technique is from Atlassian's
[Dotfiles: best way to store in a bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles).

## Install on a new machine

Needs only `git`. The commands work in bash, zsh and sh; run them from `$HOME`.

```sh
cd ~

# 1. Clone as a bare repository (HTTPS, so no key is needed yet)
git clone --bare https://codeberg.org/paroxp/dotfiles.git "$HOME/.dotfiles"

# 2. Temporary helper for this shell (the real one arrives with the checkout)
config() { git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"; }

# 3. Check the files out into $HOME
config checkout
```

If step 3 stops with `The following untracked working tree files would be
overwritten by checkout`, the machine already has some of these files (a stock
`.bashrc`, usually). Move them aside and try again:

```sh
config checkout 2>&1 | grep -E '^[[:space:]]+[^[:space:]]' | awk '{print $1}' |
  while read -r f; do
    mkdir -p ".dotfiles-backup/$(dirname "$f")" && mv "$f" ".dotfiles-backup/$f"
  done
config checkout
```

Then finish the set-up:

```sh
# 4. Only show files I have chosen to track in `config status`, and refuse
#    to add the per-machine files (see "Per-machine settings")
config config --local status.showUntrackedFiles no
printf '%s\n' /.config/git/config.local /.config/shell/local.sh \
  /.config/fish/local.fish /.config/tmux/local.conf /.ssh/config.local \
  >> ~/.dotfiles/info/exclude

# 5. A bare clone has no remote-tracking branch; add it
config config --local remote.origin.fetch '+refs/heads/*:refs/remotes/origin/*'
config fetch origin
config branch --set-upstream-to=origin/main main

# 6. Push over SSH (YubiKey), keep fetching over HTTPS
config remote set-url --push origin ssh://git@codeberg.org/paroxp/dotfiles.git

# 7. Git keeps only the executable bit, not who may read or write files;
#    ssh and gpg refuse or warn about files others can access
chmod 700 ~/.gnupg ~/.ssh
chmod 600 ~/.ssh/config ~/.gnupg/*.conf
```

Open a new shell. `config` is now defined for fish
(`~/.config/fish/functions/config.fish`), bash and zsh.

Next: set up the YubiKey for GPG and SSH by following [YUBIKEY.md](YUBIKEY.md).

## Everyday use

`config` takes any `git` command:

```sh
config status
config diff
config add ~/.config/foo/foo.conf      # start tracking, or stage a change
config commit -m "foo: add config"
config push
config pull
config ls-files                        # everything that is tracked
config rm --cached ~/.config/foo/foo.conf   # stop tracking, keep the file
```

Rules of thumb:

- Always add files by name. `config add .` and `config add -A` would try to add
  the whole home directory.
- Commit messages are `area: summary` (`fish: ...`, `gpg: ...`, `git: ...`).
- Nothing secret goes in: the repository is public. No private keys, tokens,
  shell history or machine hostnames.
- Machine-specific differences go in the untracked local files below, not in
  tracked files or branches.

## Per-machine settings

Each of these is read if it exists, after (or for ssh, before) the shared
configuration, so its values win. They are not tracked, and listed in
`~/.dotfiles/info/exclude` so `config add` refuses them.

| Tool | Local file |
|---|---|
| Git | `~/.config/git/config.local` |
| bash, zsh | `~/.config/shell/local.sh` |
| fish | `~/.config/fish/local.fish` |
| tmux | `~/.config/tmux/local.conf` |
| ssh | `~/.ssh/config.local` |

For example, to turn off commit signing on a machine without the YubiKey:

```sh
git config --file ~/.config/git/config.local commit.gpgSign false
git config --file ~/.config/git/config.local tag.gpgSign false
git config --show-origin commit.gpgSign   # shows which file set it
```

Avoid `git config --global`: it writes to the tracked `~/.config/git/config`.

## tmux on start-up

A new interactive fish, bash or zsh shell runs `~/.local/bin/tmux-pick`, which
lists running tmux sessions to attach to, plus **New session...** and **No
tmux**. `Esc` means no tmux, and detaching from tmux returns to the plain shell.

It stays out of the way inside tmux, nvim's `:terminal`, VS Code's terminal and
shells started from a shell that already asked. To skip it, set `NO_TMUX=1`
in the environment.

## What is in here

| Area | Files |
|---|---|
| Shells | `.config/fish/`, `.bashrc`, `.config/zsh/.zshrc`, `.config/shell/common.sh` (shared by bash and zsh), `.inputrc`, `.config/starship.toml` |
| Git | `.config/git/config`, `.config/git/ignore`, `.editorconfig` |
| GnuPG, SSH, YubiKey | `.gnupg/*.conf`, `.ssh/config`, `.local/bin/pinentry-auto`, [YUBIKEY.md](YUBIKEY.md) |
| Editors | `.config/nvim/`, `.config/Code/User/settings.json` |
| Terminal | `.config/tmux/tmux.conf`, `.local/bin/tmux-pick`, `.config/foot/foot.ini`, `.local/share/konsole/` |

## Colours

Everything uses the [omorfos](https://github.com/omorfos/desktop) brand's
"Prism" terminal palette: navy background, the brand's spectrum colours
and an orange cursor. foot, Konsole and VS Code's terminal define the palette;
fish, starship, tmux, fzf and `git` use its ANSI colours, so they follow
whichever terminal they run in. nvim has a matching scheme,
`.config/nvim/colors/omorfos.lua`.

To change a colour, change it in every terminal definition and in the nvim
scheme. The one exception to ANSI-only is selection: fish and tmux use the
brand's navy-3 (`#243364`) there, since bright black is the comment colour and
too light to put text on.

The shell configuration expects these to be installed, and shells print errors
at start-up until they are: `fish`, `starship`, `fzf`, `neovim`, `tmux`,
`asdf`, `gnupg`.

## Starting from scratch

For reference, this is how such a repository is created in the first place:

```sh
git init --bare "$HOME/.dotfiles"
config() { git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"; }
config config --local status.showUntrackedFiles no
config remote add origin ssh://git@codeberg.org/<user>/dotfiles.git
config add ~/.bashrc
config commit -m "bash: add bashrc"
config push -u origin main
```

The permanent definition of `config` then goes into each shell's own
configuration:

```sh
# bash / zsh
alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

```fish
# fish: ~/.config/fish/functions/config.fish
function config --wraps=git
    command git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv
end
```
