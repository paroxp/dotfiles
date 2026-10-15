# iproute2's ip is Linux only; elsewhere fish falls back to any ip command as is
if test (uname -s) = Linux
  function ip --wraps=ip --description 'IP tool with the default color scheme enabled'
    command ip --color=auto $argv
  end
end
