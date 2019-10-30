{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    arc-theme
    arc-kde-theme
    papirus-icon-theme
  ];

  fonts.fonts = with pkgs; [
    corefonts
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
