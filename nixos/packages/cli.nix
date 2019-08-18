{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    aws-vault
    awscli
    bash
    bitwarden-cli
    curl
    docker
    fish
    git
    gnupg
    go
    jq
    killall
    kubectl
    neovim
    nodejs
    pinentry
    terraform
    vim
    wget
    yubico-piv-tool
    yubikey-manager
    yubikey-personalization
    yubioath-desktop
    zsh
  ];
}
