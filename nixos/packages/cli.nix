{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    (vim_configurable.override { python = python3; })
    aws-vault
    awscli
    bash
    bind
    bitwarden-cli
    cargo
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
    rustc
    terraform
    tmux
    unzip
    weechat
    wget
    yubico-piv-tool
    yubikey-manager
    yubikey-personalization
    yubioath-desktop
    zsh
  ];
}
