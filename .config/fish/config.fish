set fish_greeting

if status is-interactive
  set -gx EDITOR nvim
  set -gx GPG_TTY (tty)
  set -gx LESS "-R"

  starship init fish | source
end

