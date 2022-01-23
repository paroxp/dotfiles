{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.developer; in {
  options.modules.developer = {
    enable = mkEnableOption "developer module";
    extraPackages = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      aws-vault
      awscli
      cargo
      docker
      gnumake
      go
      jq
      kubectl
      neovim
      nodejs
      rustc
      terraform
      yubico-piv-tool
      yubikey-manager
      yubikey-personalization
    ] ++ cfg.extraPackages
      ++ (if config.modules.desktop.enable then [
        yubioath-desktop
        vscode
      ] else []);

    environment.shellInit = ''
      export GPG_TTY="$(tty)"
      gpg-connect-agent /bye
      export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
    '';

    programs = {
      ssh.startAgent = false;

      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };

    services = {
      udev.packages = [ pkgs.yubikey-personalization pkgs.libu2f-host ];
      pcscd.enable = true;
    };
  };
}
