function fish_user_key_bindings
  # Alt+Left / Alt+Right always move a word. fish's default moves through
  # directory history instead when the command line is empty.
  bind alt-left backward-word
  bind alt-right forward-word
end
