GPG_AGENT="$(which gpg-agent)"
GPG_TTY="$(tty)"
SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

export AWS_DEFAULT_OUTPUT="json"
export AWS_DEFAULT_REGION="eu-west-2"
export EDITOR=vim
export GOPATH="${HOME}/go"
export GPG_TTY GPG_AGENT
export HISTCONTROL="ignoreboth:erasedups"
export LESS="-R"
export NIXOS_CONFIG="${HOME}/.dot/nixos"
export NVM_DIR="${HOME}/.nvm"
export PINENTRY_USER_DATA="USE_CURSES=1"
export SSH_AUTH_SOCK
export ZSH_TMUX_AUTOCONNECT=true
export ZSH_TMUX_AUTOQUIT=true

# shellcheck disable=SC2039
PATH="/usr/local/bin:${PATH}"
PATH="/usr/local/kubebuilder/bin:${PATH}"
PATH="/usr/local/opt/gpg-agent/bin:${PATH}"
PATH="${GOPATH}/bin:${PATH}"
PATH="${GOROOT}/bin:${PATH}"
PATH="${HOME}/.bin:${PATH}"
PATH="${HOME}/.cargo/bin:${PATH}"
PATH="${HOME}/.cargo/env:${PATH}"
PATH="${HOME}/.local/bin:${PATH}"
PATH="${HOME}/.rbenv/bin:${PATH}"

export PATH
