{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./local-configuration.nix
    ./options.nix
    ./users.nix
    ./modules
  ];

  nix = {
    extraOptions = "auto-optimise-store = true";
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 14d";
    };
  };

  nixpkgs.config.allowUnfree = config.allowUnfree;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = config.host.name;
    hostId = config.host.id;

    firewall.extraPackages = with pkgs; [ iproute ];

    useDHCP = false;
    interfaces.eno1.useDHCP = true;
  };

  hardware = {
    cpu = {
      amd.updateMicrocode = config.cpu == "amd";
      intel.updateMicrocode = config.cpu == "intel";
    };

    video = {
      hidpi.enable = config.hidpi;
    };
  };

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  system.stateVersion = "21.11";
}
