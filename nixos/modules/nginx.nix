{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.nginx; in {
  options.modules.nginx = {
    enable = mkEnableOption "nginx module";
    extraPackages = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nginx
    ] ++ cfg.extraPackages;

    networking.firewall.allowedTCPPorts = [
      80 443
    ];

    security = {
      acme = {
        acceptTerms = true;
        email = "paroxp@gmail.com";
      };
    };

    services = {
      nginx = {
        enable = true;

        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;

        sslCiphers = "AES256+EECDH:AES256+EDH:!aNULL";

        statusPage = true;
      };

      prometheus = mkIf config.modules.prometheus.enable {
        exporters = {
          nginx = {
            enable = true;
          };
        };

        scrapeConfigs = [
          {
            job_name = "nginx";
            static_configs = [{
              targets = [ "127.0.0.1:9113" ];
            }];
          }
        ];
      };
    };
  };
}
