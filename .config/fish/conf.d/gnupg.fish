# GnuPG / YubiKey. See ~/.github/YUBIKEY.md.
command -q gpgconf; or return

# Use gpg-agent as the SSH agent, unless an agent was forwarded to us.
if not set -q SSH_CONNECTION; or not set -q SSH_AUTH_SOCK
    set -gx SSH_AUTH_SOCK (gpgconf --list-dirs agent-ssh-socket)
end

if status is-interactive; and isatty stdin
    set -gx GPG_TTY (tty)

    # Logged in remotely: never try a GUI pinentry (read by pinentry-auto).
    if set -q SSH_CONNECTION
        set -gx PINENTRY_USER_DATA tty
    end

    # ssh cannot tell the agent which terminal it runs in, so point the agent
    # at this one before every command. Also starts the agent where nothing
    # else does (macOS, non-systemd).
    function __gpg_update_tty --on-event fish_preexec
        gpg-connect-agent updatestartuptty /bye >/dev/null 2>&1
    end
end
