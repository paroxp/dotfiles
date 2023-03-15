{ pkgs, ...}:

{
  home.packages = with pkgs; [
    cachix # Really shouldn't be keeping this in home-manager...
    (import (fetchTarball https://github.com/cachix/devenv/archive/v0.6.2.tar.gz)).default
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
