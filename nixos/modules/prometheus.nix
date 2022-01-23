{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.prometheus; in {
  options.modules.prometheus = {
    enable = mkEnableOption "prometheus module";
    extraPackages = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      prometheus
    ] ++ cfg.extraPackages;

    networking.firewall.allowedTCPPorts = [ 9090 ];

    services = {
      prometheus = {
        enable = true;

        exporters = {
          node = {
            enable = true;
            enabledCollectors = [
              "conntrack"
              "diskstats"
              "entropy"
              "filefd"
              "filesystem"
              "loadavg"
              "mdadm"
              "meminfo"
              "netdev"
              "netstat"
              "stat"
              "time"
              "vmstat"
              "systemd"
              "logind"
              "interrupts"
              "ksmd"
            ];
          };
        };

        scrapeConfigs = [
          {
            job_name = config.host.name;
            static_configs = [{
              targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
            }];
          }
        ];
      };
    };
  };
}
