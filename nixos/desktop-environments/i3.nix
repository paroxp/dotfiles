{ config, pkgs, lib, ... }:

let cfg = config.localConfiguration; in lib.mkIf (cfg.desktopEnvironment.i3.enable) {
  environment.systemPackages = with pkgs; [
    compton
    dunst
    feh
    ffmpeg
    i3lock
    lxappearance
    playerctl
    (polybar.override { i3GapsSupport = true; githubSupport = true; })
    (python3.withPackages (ps: with ps; [ python3Packages.dbus-python ]))
    rofi
    termite

    arc-gtk-theme
  ];

  services.xserver.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
  };
}
