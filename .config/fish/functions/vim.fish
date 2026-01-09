function vim --wraps=nvim --description 'Executes Neovim instead of VIM'
  command nvim $argv
end

function vi --wraps=nvim --description 'Executes Neovim instead of VI'
  command nvim $argv
end
