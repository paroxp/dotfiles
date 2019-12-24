#!/usr/bin/env bash

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

source ~/.dot/.bash/.promptrc

# Check if the custom file exists and then import it.
# shellcheck source=/dev/null
[ -f "${HOME}/.dot/.sh/customrc" ] && source "${HOME}/.dot/.sh/customrc"

# Import the aliases functionality.
# shellcheck source=/dev/null
[ -f "${HOME}/.dot/.sh/aliasrc" ] && source "${HOME}/.dot/.sh/aliasrc"

# Check if the exports file exists and then import it.
# shellcheck source=/dev/null
[ -f "${HOME}/.dot/.sh/exportrc" ] && source "${HOME}/.dot/.sh/exportrc"
