function fish_user_key_bindings
  # Alt+Left / Alt+Right always move a word. fish's default moves through
  # directory history instead when the command line is empty.
  bind alt-left backward-word
  bind alt-right forward-word

  # Tab takes the next word of the grey autosuggestion when one is showing,
  # and completes as usual otherwise. Right arrow still takes all of it.
  bind tab 'if commandline --showing-suggestion; commandline -f forward-word; else; commandline -f complete; end'
end
