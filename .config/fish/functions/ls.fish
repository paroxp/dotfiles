# GNU ls (Linux) and BSD ls (macOS) take different options for the same thing
if command ls --version >/dev/null 2>&1
  function ls --wraps=ls --description 'List contents of directory using colors and human readable form'
    command ls --color=tty --human-readable $argv
  end
else
  function ls --wraps=ls --description 'List contents of directory using colors and human readable form'
    command ls -G -h $argv
  end
end
