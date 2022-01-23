{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.jellyfin; in {
  options.modules.jellyfin = {
    enable = mkEnableOption "jellyfin module";
    extraPackages = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      jellyfin
    ] ++ cfg.extraPackages;

    networking.firewall = {
      allowedTCPPorts = [
        8096 8920
      ];
      allowedUDPPorts = [
        1900 7359
      ];
    };

    services = {
      jellyfin = {
        enable = true;
        package = pkgs.jellyfin;
      };

      nginx.virtualHosts."jellyfin" = lib.mkIf config.modules.nginx.enable {
        serverName = "jellyfin.${config.host.domain}";
        # forceSSL = true;
        # enableACME = true;

        locations = {
          "/" = {
            proxyPass = "http://127.0.0.1:8096/";
          };

          "/metrics" = {
            return = "404";
          };
        };
      };

      prometheus = mkIf config.modules.prometheus.enable {
        scrapeConfigs = [
          {
            job_name = "jellyfin";
            static_configs = [{
              targets = [ "127.0.0.1:8096" ];
            }];
          }
        ];
      };
    };
  };
}
