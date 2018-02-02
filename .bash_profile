
# Path to the bash it configuration
export BASH_IT="/Users/rafalproszowski/.bash_it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='rafal'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
# export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
# export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
# export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Load Bash It
source "$BASH_IT"/bash_it.sh

# Check if the custom file exists and then import it.
if [ -e ~/.dot/.custom ]; then
  # shellcheck source=/dev/null
  source ~/.dot/.custom
fi

# Import the aliases functionality.
# shellcheck source=/dev/null
source ~/.dot/.aliases

# Check if the exports file exists and then import it.
if [ -e ~/.dot/.exports ]; then
  # shellcheck source=/dev/null
  source ~/.dot/.exports
fi

# Check if there is a reminder in place and display it in the shell.
if [ -e ~/.dot/.reminder ] && [ "$(cat ~/.dot/.reminder)" != "" ]; then
  printf "\n!!! Reminder !!!\n"
  cat ~/.dot/.reminder
fi

