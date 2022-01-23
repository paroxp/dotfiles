{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.grafana; in {
  options.modules.grafana = {
    enable = mkEnableOption "grafana module";
    extraPackages = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = mkIf cfg.enable {
    services = {
      grafana = {
        enable = true;
        database = {
          type = "postgres";
          name = "grafana";
          user = "grafana";
          host = "/run/postgresql";
        };
      };

      nginx.virtualHosts."grafana" = lib.mkIf config.modules.nginx.enable {
        serverName = "grafana.${config.host.domain}";
        # forceSSL = true;
        # enableACME = true;

        locations = {
          "/" = {
            proxyPass = "http://127.0.0.1:3000/";
          };
        };
      };

      postgresql = mkIf config.modules.postgres.enable {
        ensureDatabases = [ "grafana" ];
        ensureUsers = [
          {
            name = "grafana";
            ensurePermissions = {
              "DATABASE grafana" = "ALL PRIVILEGES";
            };
          }
        ];
      };
    };
  };
}
