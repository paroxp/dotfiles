{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    aws-vault
    awscli
    bash
    bind
    bitwarden-cli
    curl
    docker
    fish
    git
    gnupg
    go
    jq
    kubectl
    neovim
    nodejs
    p7zip
    pinentry
    terraform
    tmux
    unzip
    (vim_configurable.override { python = python3; })
    wget
    yubico-piv-tool
    yubikey-manager
    yubikey-personalization
    yubioath-desktop
    zsh
  ];
}
