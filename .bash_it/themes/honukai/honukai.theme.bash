#!/usr/bin/env bash


box_name=$([ -f ~/.box-name ] && cat ~/.box-name)

# VCS
SCM_THEME_PROMPT_DIRTY="${red} ✖︎"
SCM_THEME_PROMPT_CLEAN="${green} ●"
SCM_THEME_PROMPT_PREFIX1="${white} on ${reset_color}"
SCM_THEME_PROMPT_PREFIX2=":${cyan}"
SCM_THEME_PROMPT_PREFIX="${SCM_THEME_PROMPT_PREFIX1}git${SCM_THEME_PROMPT_PREFIX2}"
SCM_THEME_PROMPT_SUFFIX="${reset_color}"

# Git info.
GIT_THEME_PROMPT_DIRTY="${SCM_THEME_PROMPT_DIRTY}"
GIT_THEME_PROMPT_CLEAN="${SCM_THEME_PROMPT_CLEAN}"
GIT_THEME_PROMPT_PREFIX="${SCM_THEME_PROMPT_PREFIX}"
GIT_THEME_PROMPT_SUFFIX="${SCM_THEME_PROMPT_SUFFIX}"

function prompt_command() {
  # Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE [TIME] \n $
  PS1="\n${bold}${blue}#${reset_color} ${cyan}\u ${white}at ${green}${box_name:-\h} ${white}in ${bold}${yellow}\w${reset_color}$(scm_prompt_info) ${white}[\T]\n${bold}${red}→ ${reset_color}"
}

safe_append_prompt_command prompt_command
