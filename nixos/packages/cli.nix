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
    pinentry
    terraform
    tmux
    (vim_configurable.override { python = python3; })
    wget
    yubico-piv-tool
    yubikey-manager
    yubikey-personalization
    yubioath-desktop
    zsh
  ];
}
