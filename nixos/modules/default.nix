{ ... }:

{
  imports = [
    ./common.nix
    ./desktop.nix
    ./developer.nix
    ./grafana.nix
    ./jellyfin.nix
    ./nextcloud.nix
    ./nginx.nix
    ./postgres.nix
    ./prometheus.nix
  ];
}
