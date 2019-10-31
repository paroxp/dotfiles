{ config, pkgs, lib, ... }:

let cfg = config.localConfiguration; in lib.mkIf (cfg.build.standard.enable) {
  environment.systemPackages = with pkgs; [
    bash
    bind
    bitwarden-cli
    coreutils
    curl
    dnsutils
    file
    git
    gnupg
    htop
    killall
    p7zip
    pinentry
    unzip
    weechat
    wget
    whois
    xclip
    zip
    zsh

    firefox
    google-chrome
    slack
    spotify
    thunderbird
    vlc

    arc-theme
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

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
    };
  };

  services.xserver = {
    enable = true;
    autorun = true;
    layout = "us";

    desktopManager = {
      xterm.enable = false;
    };

    displayManager = {
      sddm = {
        enable = (cfg.displayManager == "sddm");
        autoNumlock = true;
        theme = "breeze";
      };
      gdm = {
        enable = (cfg.displayManager == "gdm");
        wayland = false;
      };
    };
  };

  services.accounts-daemon.enable = true;
}
