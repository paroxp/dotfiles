# YubiKey + GnuPG + SSH + Pinentry

How these dotfiles use a YubiKey for GPG and SSH, what has to be done once per
machine, and how to debug it. Meant to work on Linux (any desktop or none) and
macOS.

## 1. How the pieces fit

```
ssh ──(SSH_AUTH_SOCK)──► gpg-agent ──► scdaemon ──(CCID/USB)──► YubiKey
gpg ──(S.gpg-agent)────►     │
                             └──► pinentry  (asks for the card PIN)
```

- `gpg-agent` is one long-lived process shared by every TTY, terminal window
  and graphical session. On systemd machines it is socket-activated; elsewhere
  the first `gpg` or `gpg-connect-agent` call starts it.
- Keys live on the card; `~/.gnupg/private-keys-v1.d/*.key` are only stubs.
  - `0xC4CE726F8465B7FC` [SC], `0xB712A87560A48C53` [E], `0x10B9CC9B00B9679E` [A, used for SSH]
- **The card caches the PIN, not the agent.** Once verified, the card stays
  unlocked until it is unplugged or scdaemon is reset. `default-cache-ttl` /
  `max-cache-ttl` do not apply to card PINs.

Because one agent serves many terminals, it has to be told *where* to show the
pinentry for each request:

- `gpg` tells it every time (it sends its own `GPG_TTY`, `WAYLAND_DISPLAY`, ...).
- `ssh` **cannot**; the ssh-agent protocol has no field for it. For SSH requests
  the agent uses its "startup TTY": whatever the last
  `gpg-connect-agent updatestartuptty /bye` gave it. The fish `preexec` hook and
  the `Match exec` line in `~/.ssh/config` exist to keep that current.

Two rules that follow from this, and were the cause of past flakiness:

- Never export `GPG_TTY` from a non-interactive shell. `tty` prints
  `not a tty` there, and a desktop session will happily import that into the
  environment the agent starts with.
- Only one thing may provide `SSH_AUTH_SOCK` (see section 3).

## 2. How `pinentry-auto` decides

`gpg-agent.conf` points at `~/.local/bin/pinentry-auto`, which picks a pinentry
per request. In order:

1. `PINENTRY_USER_DATA=tty` or `=gui` in the requesting shell: obey it. The
   shells set `tty` automatically when logged in over SSH.
2. macOS: GUI (`pinentry-mac`).
3. Request typed on a kernel console (`GPG_TTY=/dev/ttyN`) and the session is
   not `wayland`/`x11`: terminal pinentry, even if the agent still remembers a
   display from another session.
4. A Wayland socket exists or `DISPLAY` is set: GUI.
5. Otherwise: terminal pinentry.

"GUI" is the first of these that is installed: `pinentry-mac`, `pinentry-x11`
(Debian's alternative for the preferred GUI one), `pinentry-gnome3`,
`pinentry-qt`, `pinentry-qt5`, `pinentry-gtk-2`, `pinentry-gtk2`,
`pinentry-gtk`, `pinentry-fltk`. "Terminal" is `pinentry-curses`, then
`pinentry-tty`, then plain `pinentry`. With no GUI pinentry installed it falls
back to the terminal one.

Known limits:

- tmux/screen on a console while a graphical session is also running looks like
  a graphical terminal. `set -x PINENTRY_USER_DATA tty` in that shell.
- Rule 4 only checks that the Wayland socket *file* exists; a crashed
  compositor can leave one behind.
- `pinentry-gnome3` needs the GCR prompter over D-Bus. Fine under GNOME, not
  guaranteed under other compositors. If no dialog appears, install
  `pinentry-qt` or `pinentry-gtk2` and, on Debian, select it with
  `sudo update-alternatives --config pinentry-x11`.
- To prefer a different GUI pinentry on one machine, reorder the `gui=` list.
- gpg-agent 2.4 expands `~` in `pinentry-program`. If an older GnuPG does not,
  use the absolute path in that machine's `gpg-agent.conf`.

## 3. Per-machine setup (not in the dotfiles)

### Linux with systemd

Several user units each set `SSH_AUTH_SOCK` when they start, and the last one
wins. Mask everything except gpg-agent (skip units that do not exist):

```fish
systemctl --user mask --now ssh-agent.socket ssh-agent.service \
                            gcr-ssh-agent.socket gcr-ssh-agent.service
systemctl --user set-environment SSH_AUTH_SOCK=(gpgconf --list-dirs agent-ssh-socket)
gpgconf --kill all
```

Undo with `systemctl --user unmask <units>`.

### macOS

`brew install gnupg pinentry-mac ykman`. Nothing to mask. Shells are covered by
the dotfiles; graphical apps keep using the launchd ssh-agent.

### Any new machine

1. Install GnuPG, scdaemon, a terminal pinentry, and a GUI pinentry if there is
   a desktop. Debian/Ubuntu:
   `sudo apt install gnupg scdaemon pinentry-curses yubikey-manager` plus
   `pinentry-gnome3` or `pinentry-qt`.
2. Check out the dotfiles; make sure `~/.local/bin/pinentry-auto` is executable.
3. Import the public key: `gpg --recv-keys 0xC4CE726F8465B7FC` (or
   `gpg --card-edit` → `fetch` if the URL is set on the card).
4. Plug in the key and run `gpg --card-status` to create the key stubs.
5. `gpg --edit-key 0xC4CE726F8465B7FC` → `trust` → `5`.
6. Do the platform steps above, open a new shell, then verify.

## 4. Verifying

```fish
echo $SSH_AUTH_SOCK                # .../S.gpg-agent.ssh
echo $GPG_TTY                      # /dev/ttyN, /dev/pts/N or /dev/ttysNNN
gpg --card-status                  # card visible
ssh-add -L                         # shows "... cardno:..." key
gpg-connect-agent 'scd reset' /bye # lock the card again
ssh -T git@codeberg.org            # pinentry must appear in THIS terminal
```

Repeat the last two lines from a second console, and from a terminal inside a
graphical session (should get a dialog there). On systemd machines,
`systemctl --user show-environment | grep -E 'SSH_AUTH_SOCK|GPG_TTY'` should
show one `SSH_AUTH_SOCK` line pointing at gpg-agent and no `GPG_TTY` line. If
`GPG_TTY` is there, `systemctl --user unset-environment GPG_TTY` and find what
exports it from a non-interactive shell.

## 5. Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| `sign_and_send_pubkey: signing failed ... agent refused operation` | Pinentry could not be shown | `gpg-connect-agent updatestartuptty /bye`, then retry. Check `echo $GPG_TTY`. |
| Agent log: `Inappropriate ioctl for device <Pinentry>` | Agent's TTY is wrong or stale | Same as above. |
| Pinentry appears in another terminal or console | Startup TTY points elsewhere | Same as above. |
| Only works after `gpg --card-edit` → `verify` | Same: gpg can show the pinentry, ssh cannot | Same as above. |
| GUI dialog wanted but got curses, or the reverse | `pinentry-auto` guessed wrong | `set -x PINENTRY_USER_DATA gui` (or `tty`) in that shell. See section 2. |
| `ssh-add -L`: `The agent has no identities` | Card missing, or wrong agent | Check `gpg --card-status` and `echo $SSH_AUTH_SOCK`. |
| `gpg: selecting card failed: No such device` | Card unplugged, or `pcscd` holds it (after `ykman`, `yubico-piv-tool`) | Replug, or `sudo systemctl stop pcscd; gpgconf --kill scdaemon`. |
| `ykman` cannot connect to the card | scdaemon holds the USB device | `gpgconf --kill scdaemon`, run `ykman`, carry on (scdaemon restarts on demand). |
| Unexpected repeat PIN prompts | Something switched applet on the key (PIV, OTP tools) | Expected after `ykman`; `scdaemon.conf` disables PIV probing by GnuPG itself. |
| Card wedged after suspend or replug | scdaemon lost the device | `gpgconf --kill scdaemon` or `gpg-connect-agent 'scd reset' /bye`. |
| `gpg: signing failed: No secret key` with a different YubiKey | Stubs point at the other card's serial | `gpg-connect-agent 'scd serialno' 'learn --force' /bye` |
| No prompt and it just hangs | Key has a touch policy and is waiting | Touch the key. |

Useful commands (the `journalctl`/`systemctl` ones are systemd only):

```fish
journalctl --user -u gpg-agent -f                       # agent + scdaemon log
gpg-connect-agent 'getinfo std_startup_env' /bye        # where SSH pinentries go
gpg-connect-agent 'scd getinfo reader_list' /bye        # readers scdaemon sees
gpgconf --kill all                                      # restart everything
echo GETPIN | pinentry-auto                             # test the pinentry directly
systemctl --user list-units '*ssh*' '*gpg*' '*gcr*'     # who is running
```

For more detail from scdaemon, temporarily add to `scdaemon.conf`:

```
log-file /tmp/scdaemon.log
debug-level guru
```

(remove afterwards: the log includes APDUs).
