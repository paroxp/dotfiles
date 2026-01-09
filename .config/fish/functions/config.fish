function config --wraps=git --description 'Git wrapper specifically for dotfiles management'
  command git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $argv
end
