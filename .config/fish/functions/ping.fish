function ping  --wraps=ping --description 'Ping the target 5 times'
  command ping -c 5 $argv
end
