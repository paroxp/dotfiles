{ config, pkgs, lib, ... }:

let cfg = config.localConfiguration; in lib.mkIf (cfg.build.gamer.enable) {
  environment.systemPackages = with pkgs; [
    discord
    steam
  ];
}
