set fish_greeting

if status is-interactive
  set -gx EDITOR nvim
  set -gx LESS "-R"
  set -gx FZF_DEFAULT_OPTS "--color=16,prompt:blue,pointer:yellow,hl:yellow,hl+:yellow,marker:green"
end

