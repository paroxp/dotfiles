{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.nextcloud; in {
  options.modules.nextcloud = {
    enable = mkEnableOption "nextcloud module";
    extraPackages = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [

    ] ++ cfg.extraPackages;

    services = {
      nextcloud = {
        enable = true;
        package = pkgs.nextcloud23;
        hostName = "nextcloud.${config.host.domain}";
        home = "/storage/nextcloud";

        autoUpdateApps.enable = true;
        autoUpdateApps.startAt = "05:00:00";

        config = {
          # overwriteProtocol = "https";

          dbtype = "pgsql";
          dbuser = "nextcloud";
          dbhost = "/run/postgresql";
          dbname = "nextcloud";

          adminuser = "paroxp";
          adminpassFile = "/var/secrets/nextcloud-admin-password";
        };
      };

      postgresql = lib.mkIf config.modules.postgres.enable {
        ensureDatabases = [ "nextcloud" ];
        ensureUsers = [
          {
            name = "nextcloud";
            ensurePermissions = {
              "DATABASE nextcloud" = "ALL PRIVILEGES";
            };
          }
        ];
      };

      prometheus = lib.mkIf config.modules.prometheus.enable {
        exporters = {
          nextcloud = {
            enable = true;
            url = "nextcloud.${config.host.domain}";
            user = "nextcloud";
            passwordFile = "/var/secrets/nextcloud-admin-password";
          };
        };

        scrapeConfigs = [
          {
            job_name = "nextcloud";
            static_configs = [{
              targets = [ "127.0.0.1:9205" ];
            }];
          }
        ];
      };
    };

    systemd.services."nextcloud-setup" = {
      requires = ["postgresql.service"];
      after = ["postgresql.service"];
    };
  };
}
