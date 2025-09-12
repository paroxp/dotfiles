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

    stateVersion = "24.05";

    packages = with pkgs; [
      pkgs.nerd-fonts.fira-code
    ];

    sessionVariables = with pkgs; {
      EDITOR = neovim;
      LESS = "-R";
      PATH = builtins.concatStringsSep ":" [
        "$HOME/.nix-profile/bin"
        "/nix/var/nix/profiles/default/bin"
        "/usr/local/bin"
        "$HOME/.local/bin"
        "$PATH"
      ];
    };
  };

  targets.genericLinux.enable = pkgs.stdenv.isLinux;
}
