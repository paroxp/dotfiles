{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    adapta-gtk-theme
    arc-theme
    numix-gtk-theme
    papirus-icon-theme
  ];

  fonts.fonts = with pkgs; [
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira
    fira-code
    fira-mono
  ];
}
