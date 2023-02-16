# Directory info.
local current_dir='${PWD/#$HOME/~}'

# VCS
YS_VCS_PROMPT_PREFIX1=" %{$fg[white]%}on%{$reset_color%} "
YS_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
YS_VCS_PROMPT_SUFFIX="%{$reset_color%}"
YS_VCS_PROMPT_DIRTY=" %{$fg[red]%}✖︎"
YS_VCS_PROMPT_CLEAN=" %{$fg[green]%}●"

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${YS_VCS_PROMPT_PREFIX1}git${YS_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$YS_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$YS_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$YS_VCS_PROMPT_CLEAN"

local ret_status="%(?:%{$terminfo[bold]$fg_bold[green]%}:%{$terminfo[bold]$fg_bold[red]%})"
local user_indicator="%(!.%{$terminfo[bold]$fg_bold[red]%}#.%{$terminfo[bold]$fg[blue]%}$)"
local devenv='${GREET:+"(${GREET}) "}'

# Prompt format: \n # [TIME] DIRECTORY on git:BRANCH STATE (DEVENV) \n $
PROMPT="
%{$fg[white]%}[%*] \
${user_indicator}%{$reset_color%} \
%{$terminfo[bold]$fg[yellow]%}${current_dir}%{$reset_color%}\
${git_info}%{$reset_color%}
%{$fg[yellow]%}${devenv}%{$reset_color%}${ret_status}→ %{$reset_color%}"
