# Syntax highlighting in ANSI colours, so fish follows the terminal palette
# (Honukai in Konsole) and matches starship, tmux, fzf and nvim's honukai
# scheme: blue commands, magenta keywords, green strings, yellow highlights.
#
# These are globals, so they win over universal values that `fish_config`
# writes to fish_variables. Change colours here, not through `fish_config`.

# Command line
set -g fish_color_normal normal
set -g fish_color_command brblue
set -g fish_color_keyword magenta
set -g fish_color_param normal
set -g fish_color_option cyan
set -g fish_color_quote green
set -g fish_color_escape brcyan
set -g fish_color_operator cyan
set -g fish_color_redirection cyan --bold
set -g fish_color_end cyan
set -g fish_color_error brred
set -g fish_color_comment brblack --italics
set -g fish_color_autosuggestion brblack
set -g fish_color_valid_path --underline
set -g fish_color_cancel -r
set -g fish_color_history_current --bold
set -g fish_color_search_match yellow --background=brblack
set -g fish_color_selection white --bold --background=brblack

# Used by fish's own prompts; starship uses the same colours
set -g fish_color_user yellow
set -g fish_color_host green
set -g fish_color_host_remote green
set -g fish_color_cwd yellow
set -g fish_color_cwd_root red
set -g fish_color_status red

# Completion pager
set -g fish_pager_color_completion normal
set -g fish_pager_color_prefix yellow --bold --underline
set -g fish_pager_color_description brblack --italics
set -g fish_pager_color_progress brwhite --background=blue
set -g fish_pager_color_selected_background --background=brblack
