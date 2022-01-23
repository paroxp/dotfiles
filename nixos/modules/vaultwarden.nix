{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.vaultwarden; in {
  options.modules.vaultwarden = {
    enable = mkEnableOption "vaultwarden module";
    extraPackages = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
    port = mkOption {
      type = types.str;
      default = "8812";
    };
    websocketPort = mkOption {
      type = types.str;
      default = "3012";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [

    ] ++ cfg.extraPackages;

    services = {
      vaultwarden = {
        enable = true;
        dbBackend = lib.mkIf config.modules.postgres.enable "postgresql";

        config = {
          DATABASE_URL = lib.mkIf config.modules.postgres.enable "postgresql://vaultwarden@/vaultwarden";
          WEB_VAULT_FOLDER = "${pkgs.bitwarden_rs-vault}/share/bitwarden_rs/vault";
          WEB_VAULT_ENABLED = true;
          LOG_FILE = "/var/log/vaultwarden";
          WEBSOCKET_ENABLED = true;
          WEBSOCKET_ADDRESS = "127.0.0.1";
          WEBSOCKET_PORT = cfg.websocketPort;
          SIGNUPS_VERIFY = true;
          SIGNUPS_ALLOWED = false;
          INVITATIONS_ALLOWED = false;
          # ADMIN_TOKEN = (import /etc/nixos/secret/bitwarden.nix).ADMIN_TOKEN;
          DOMAIN = "https://bitwarden.nord.icu";
          # YUBICO_CLIENT_ID = (import /etc/nixos/secret/bitwarden.nix).YUBICO_CLIENT_ID;
          # YUBICO_SECRET_KEY = (import /etc/nixos/secret/bitwarden.nix).YUBICO_SECRET_KEY;
          YUBICO_SERVER = "https://api.yubico.com/wsapi/2.0/verify";
          SMTP_HOST = "mx.nord.icu";
          SMTP_FROM = "bitwarden@nord.icu";
          SMTP_FROM_NAME = "Bitwarden";
          SMTP_PORT = 587;
          SMTP_SSL = true;
          # SMTP_USERNAME = (import /etc/nixos/secret/bitwarden.nix).SMTP_USERNAME;
          # SMTP_PASSWORD = (import /etc/nixos/secret/bitwarden.nix).SMTP_PASSWORD;
          SMTP_USERNAME = "asda";
          SMTP_PASSWORD = "asda";
          SMTP_TIMEOUT = 15;
          ROCKET_ADDRESS = "127.0.0.1";
          ROCKET_PORT = cfg.port;
        };
      };

      postgresql = lib.mkIf config.modules.postgres.enable {
        ensureDatabases = [ "vaultwarden" ];
        ensureUsers = [
          {
            name = "vaultwarden";
            ensurePermissions = {
              "DATABASE vaultwarden" = "ALL PRIVILEGES";
            };
          }
        ];
      };

      # fail2ban.jails = {
      #   vaultwarden = ''
      #     enabled = true
      #     filter = vaultwarden
      #     port = http,https
      #     maxretry = 5
      #   '';

      #   vaultwarden-admin = ''
      #     enabled = true
      #     filter = vaultwarden-admin
      #     port = http,https
      #     maxretry = 2
      #   '';
      # };
    };

    # environment.etc = {
    #   "fail2ban/filter.d/vaultwarden.conf".text = ''
    #     [Definition]
    #     failregex = ^.*Username or password is incorrect\. Try again\. IP: <ADDR>\. Username:.*$
    #     ignoreregex =
    #     journalmatch = _SYSTEMD_UNIT=vaultwarden.service
    #   '';

    #   "fail2ban/filter.d/vaultwarden-admin.conf".text = ''
    #     [Definition]
    #     failregex = ^.*Invalid admin token\. IP: <ADDR>.*$
    #     ignoreregex =
    #     journalmatch = _SYSTEMD_UNIT=vaultwarden.service
    #   '';
    # };

    services.nginx.virtualHosts."vaultwarden" = lib.mkIf config.modules.nginx.enable {
      serverName = "bitwarden.${config.host.domain}";
      # forceSSL = true;
      # enableACME = true;

      locations."/" = {
        proxyPass = "http://127.0.0.1:${cfg.port}";
        proxyWebsockets = true;
      };
      locations."/notifications/hub" = {
        proxyPass = "http://127.0.0.1:${cfg.websocketPort}";
        proxyWebsockets = true;
      };
      locations."/notifications/hub/negotiate" = {
        proxyPass = "http://127.0.0.1:${cfg.port}";
        proxyWebsockets = true;
      };
    };

    # systemd.services.vaultwarden.serviceConfig = {
    #   EnvironmentFile = [ config.sops.secrets.bitwarden-smtp-password.path ];
    #   Restart = "on-failure";
    #   RestartSec = "2s";
    # };
  };
}
