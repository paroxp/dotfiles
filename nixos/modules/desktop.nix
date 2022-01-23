{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.desktop; in {
  options.modules.desktop = {
    enable = mkEnableOption "desktop module";
    extraPackages = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
    desktopEnvironment = mkOption {
      type = types.enum [ "gnome" "kde" ];
      default = "gnome";
    };
    videoDrivers = mkOption {
      type = types.listOf types.str;
      default = [ "nvidia" ];
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      discord
      firefox
      google-chrome
      slack
      spotify
      steam
      thunderbird
      vlc

      arc-theme
      papirus-icon-theme
    ] ++ cfg.extraPackages
      ++ (if cfg.desktopEnvironment == "gnome" then [
        arc-gtk-theme
      ] else [])
      ++ (if cfg.desktopEnvironment == "kde" then [
        arc-kde-theme
        ark
        dolphin
        gwenview
        kdeApplications.dolphin-plugins
        kdeplasma-addons
        kgpg
        konsole
        okular
        pinentry_qt5
        yakuake
      ] else []);

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

    sound.enable = true;

    hardware = {
      opengl.driSupport32Bit = true;
      pulseaudio = {
        enable = true;
        support32Bit = true;
      };
    };

    services = {
      accounts-daemon.enable = true;
      xserver = {
        enable = true;
        autorun = true;
        layout = "us";
        videoDrivers = cfg.videoDrivers;

        desktopManager = {
          xterm.enable = false;

          gnome3.enable = cfg.desktopEnvironment == "gnome";
          plasma5.enable = cfg.desktopEnvironment == "kde";
        };

        displayManager = {
          gdm = {
            enable = builtins.elem cfg.desktopEnvironment [ "gnome" ];
            wayland = true;
          };
          sddm = {
            enable = builtins.elem cfg.desktopEnvironment [ "kde" ];
            autoNumlock = true;
            theme = "breeze";
          };
        };
      };

      gnome3 = mkIf (cfg.desktopEnvironment == "gnome") {
        gnome-keyring.enable = true;
      };
    };
  };
}
