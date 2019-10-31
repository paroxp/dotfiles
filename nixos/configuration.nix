{ config, pkgs, lib, ... }:

{
  imports = [
    ./build
    ./desktop-environments
    ./hardware-configuration.nix
    ./users.nix
  ];

  options.localConfiguration = with lib; {
    hostName = mkOption {
      type = types.str;
      default = "nixos";
    };
    displayManager = mkOption {
      type = types.enum [ "gdm" "sddm" ];
      default = "sddm";
    };
    videoDrivers = mkOption {
      type = types.listOf types.str;
      default = [ "nvidia" ];
    };
    build = {
      standard = {
        enable = mkOption {
          type = types.bool;
          default = true;
        };
      };
      developer = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
      gamer = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
    desktopEnvironment = {
      gnome = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
      i3 = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
      kde = {
        enable = mkOption {
          type = types.bool;
          default = false;
        };
      };
    };
    allowUnfree = mkOption {
      type = types.bool;
      default = false;
    };
    nixpkgs = mkOption {
      type = types.nullOr types.str;
      default = null;
    };
  };

  config = let localConfiguration = (import ./local-configuration.nix) {
    inherit pkgs;
  };

  cfg = config.localConfiguration; in {
    nix = {
      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 30d";
      };
    } // lib.optionalAttrs (cfg.nixpkgs != null) {
      nixPath = [
        "nixpkgs=${cfg.nixpkgs}"
        "nixos-config=/etc/nixos/configuration.nix"
      ];
    };

    # This enables type checking
    localConfiguration = localConfiguration;

    nixpkgs.config.allowUnfree = cfg.allowUnfree;

    sound.enable = true;

    hardware.opengl.driSupport32Bit = true;
    hardware.pulseaudio.enable = true;
    hardware.pulseaudio.support32Bit = true;

    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    networking = {
      hostName = cfg.hostName;
      networkmanager.enable = true;
    };

    i18n = {
      consoleKeyMap = "us";
      defaultLocale = "en_US.UTF-8";
    };

    time.timeZone = "Europe/London";

    services.xserver.videoDrivers = cfg.videoDrivers;

    # This value determines the NixOS release with which your system is to be
    # compatible, in order to avoid breaking some software such as database
    # servers. You should change this only after NixOS release notes say you
    # should.
    system.stateVersion = "19.09"; # Did you read the comment?
  };

}
