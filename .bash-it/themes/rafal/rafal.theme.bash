#!/usr/bin/env bash

SCM_THEME_PROMPT_PREFIX="${white}on${reset_color} git:${cyan}"
SCM_THEME_PROMPT_SUFFIX="${reset_color}"
SCM_THEME_PROMPT_DIRTY=" ${red}✖︎"
SCM_THEME_PROMPT_CLEAN=" ${green}●"

GIT_PROMPT_PREFIX="${white}on${reset_color} git:${cyan}"
GIT_PROMPT_SUFFIX="${reset_color}"
GIT_PROMPT_DIRTY=" ${red}✖︎"
GIT_PROMPT_CLEAN=" ${green}●"

# Machine name.
__rafal_box_name() {
    [ -f ~/.box-name ] && cat ~/.box-name || printf "\h"
}

__rafal_environment() {
  if [ ! -z ${_ENVIRONMENT:-} ]; then
      printf "${_ENVIRONMENT} "
  fi
}

__rafal_scm_info() {
  if [ -d ".git" ]; then
    printf " ${SCM_THEME_PROMPT_PREFIX}$(git rev-parse --abbrev-ref HEAD)"

    if [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]]; then
      printf "${SCM_THEME_PROMPT_DIRTY}"
    else
      printf "${SCM_THEME_PROMPT_CLEAN}"
    fi
  fi
}

function prompt_command() {
    PS1="${blue}#${reset_color} ${cyan}\u ${white}at ${green}$(__rafal_box_name) ${white}in ${yellow}\w${reset_color}$(__rafal_scm_info) ${white}[\t]\n${red}$(__rafal_environment)→${reset_color} "
}

safe_append_prompt_command prompt_command
