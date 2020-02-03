#!/usr/bin/env bash

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

# Check if the custom file exists and then import it.
# shellcheck source=/dev/null
[ -f "${HOME}/.dot/.sh/customrc" ] && source "${HOME}/.dot/.sh/customrc"

# Import the aliases functionality.
# shellcheck source=/dev/null
[ -f "${HOME}/.dot/.sh/aliasrc" ] && source "${HOME}/.dot/.sh/aliasrc"

# Check if the exports file exists and then import it.
# shellcheck source=/dev/null
[ -f "${HOME}/.dot/.sh/exportrc" ] && source "${HOME}/.dot/.sh/exportrc"

source ~/.dot/.bash/.promptrc

bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'TAB:menu-complete'
bind '"\e[A": history-search-backward'
bind '"\eOA": history-previous-history'
bind '"\e[B": history-search-forward'
bind '"\eOB": history-next-history'

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi
