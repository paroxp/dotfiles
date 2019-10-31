{ config, pkgs, lib, ... }:

let cfg = config.localConfiguration; in lib.mkIf (cfg.build.developer.enable) {
  environment.systemPackages = with pkgs; [
    (vim_configurable.override { python = python3; })
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
    tmux
    yubico-piv-tool
    yubikey-manager
    yubikey-personalization
    yubioath-desktop

    vscode
  ];

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

  services.udev.packages = [ pkgs.yubikey-personalization pkgs.libu2f-host ];
  services.openssh.enable = true;
  services.pcscd.enable = true;
}
