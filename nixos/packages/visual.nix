{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    arc-theme
    arc-kde-theme
    papirus-icon-theme
  ];

  fonts.fonts = with pkgs; [
    corefonts
    dejavu_fonts
    fira
    fira-code
    fira-code-symbols
    fira-mono
    freefont_ttf
    liberation_ttf
    nerdfonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    source-code-pro
    source-sans-pro
    unifont
  ];
}
