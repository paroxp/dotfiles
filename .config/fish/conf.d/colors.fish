# Syntax highlighting in ANSI colours, so fish follows the terminal palette
# (omorfos Prism in Ghostty) and matches starship, tmux, fzf and
# nvim's omorfos scheme: blue commands, magenta keywords, green strings,
# yellow highlights.
#
# Selection backgrounds are the brand's navy-3 (243364) rather than an ANSI
# colour: bright black is the comment colour, too light to put text on.
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
set -g fish_color_search_match yellow --background=243364
set -g fish_color_selection brwhite --bold --background=243364

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
set -g fish_pager_color_progress black --background=cyan
set -g fish_pager_color_selected_background --background=243364
