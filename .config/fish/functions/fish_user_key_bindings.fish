function fish_user_key_bindings
  # Alt+Left / Alt+Right always move a word. fish's default moves through
  # directory history instead when the command line is empty.
  bind alt-left backward-word
  bind alt-right forward-word

  # Tab takes the next word of the grey autosuggestion when one is showing,
  # and completes as usual otherwise. Right arrow still takes all of it.
  bind tab 'if commandline --showing-suggestion; __accept_suggested_word; else; commandline -f complete; end'
end

# Takes the next word of the autosuggestion, and the space after it if one
# follows, so the next word can be typed straight away. forward-word alone
# stops before the space. Peeking one character and undoing it when it is
# not a space keeps forward-word's word boundaries, such as `src` and `/`.
function __accept_suggested_word
  commandline -f forward-word
  commandline --showing-suggestion; or return
  set -l before "$(commandline --current-buffer)"
  commandline -f forward-single-char
  set -l after "$(commandline --current-buffer)"
  # The suggestion can equal the buffer, and then nothing was taken.
  if test "$after" != "$before"; and test (string sub --start -1 -- "$after") != ' '
    commandline -f undo
  end
end
