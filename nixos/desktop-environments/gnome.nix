{ config, pkgs, lib, ... }:

let cfg = config.localConfiguration; in lib.mkIf (cfg.desktopEnvironment.gnome.enable) {  
  environment.systemPackages = with pkgs; [
    arc-gtk-theme
  ];

  services.gnome3 = {
    chrome-gnome-shell.enable = true;
    gnome-keyring.enable = true;
  };

  services.xserver.desktopManager.gnome3.enable = true;
}
