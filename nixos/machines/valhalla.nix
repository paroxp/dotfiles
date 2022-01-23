{ ... }:

{
  hidpi = false;

  host = {
    domain = "nord.icu";
    name = "valhalla";
    id = "91c320c4";
  };

  modules = {
    common.enable = true;
    developer.enable = true;
    grafana.enable = true;
    jellyfin.enable = true;
    nextcloud.enable = true;
    nginx.enable = true;
    postgres.enable = true;
    prometheus.enable = true;
  };
}
