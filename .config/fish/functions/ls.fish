function ls --wraps=ls --description 'List contents of directory using colors and human readable form'
  command ls --color=tty --human-readable $argv
end
