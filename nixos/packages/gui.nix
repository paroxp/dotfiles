{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    discord
    firefox
    google-chrome
    spotify
    steam
    vlc
    vscode
  ];
}
