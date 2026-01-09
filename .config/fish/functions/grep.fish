function grep --wraps=grep --description 'Search for PATTERNS in each FILE whilst highlighting the findings'
  command grep --color=tty $argv
end
