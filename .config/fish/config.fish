set fish_greeting

if status is-interactive
  set -gx EDITOR nvim
  set -gx LESS "-R"
  set -gx FZF_DEFAULT_OPTS "--color=16,prompt:blue,pointer:yellow,hl:yellow,hl+:yellow,marker:green --bind=alt-left:backward-word,alt-right:forward-word"
end

# Per-machine settings, not tracked. Not in conf.d, which runs before this file
# and so could not override it.
test -r ~/.config/fish/local.fish; and source ~/.config/fish/local.fish

# Offer to attach to a tmux session; see ~/.local/bin/tmux-pick.
# TMUX_PICKED stops shells started from this one from asking again.
if status is-interactive; and not set -q TMUX_PICKED; and test -x $HOME/.local/bin/tmux-pick
  set -gx TMUX_PICKED 1
  $HOME/.local/bin/tmux-pick
end
