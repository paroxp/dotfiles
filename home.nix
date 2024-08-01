{ pkgs, ... }:

let cfg = import ./config.nix; inherit (pkgs) stdenv; in {
  imports = [
    ./devenv.nix
    ./editorconfig.nix
    ./git.nix
    ./gpg.nix
    ./starship.nix
    ./tmux.nix
    ./vim.nix
    ./vscode.nix
    ./zsh.nix
  ];

  programs = {
    home-manager.enable = true;
  };

  fonts.fontconfig.enable = true;

  home = {
    username = cfg.user.name;
    homeDirectory = "/home/${cfg.user.name}";

    stateVersion = "23.05";

    packages = with pkgs; [
      _1password
      (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];

    sessionVariables = with pkgs; {
      EDITOR = neovim;
      LESS = "-R";
      PATH = builtins.concatStringsSep ":" [
        "/usr/local/bin"
        "$HOME/.local/bin"
        "$PATH"
      ];
    };
  };

  targets.genericLinux.enable = pkgs.stdenv.isLinux;
}
