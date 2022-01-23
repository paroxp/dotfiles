{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.postgres; in {
  options.modules.postgres = {
    enable = mkEnableOption "postgres module";
    extraPackages = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };


  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [

    ] ++ cfg.extraPackages;

    services = {
      postgresql = {
        enable = true;
        package = pkgs.postgresql_14;
        dataDir = "/storage/databases";
      };

      prometheus = lib.mkIf config.modules.prometheus.enable {
        exporters = {
          postgres = {
            enable = true;
            extraFlags = [ "--auto-discover-databases" ];
          };
        };

        scrapeConfigs = [
          {
            job_name = "postgres";
            static_configs = [{
              targets = [ "127.0.0.1:9187" ];
            }];
          }
        ];
      };
    };
  };
}
