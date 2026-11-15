# Login-shell settings. With ZDOTDIR set (see ~/.zshenv), zsh looks here
# instead of ~/.zprofile, so keep reading a machine's existing file first.
if [ -r "$HOME/.zprofile" ]; then
    . "$HOME/.zprofile"
fi

# Homebrew on macOS: Apple Silicon first, then Intel. Skip it when a file
# read above already put brew on PATH, so the entries are not duplicated.
if ! command -v brew >/dev/null 2>&1; then
    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
fi
