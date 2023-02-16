{ pkgs, ... }:

{
  imports = [ ./devenv.nix ./git.nix ./gpg.nix ./tmux.nix ./vim.nix ./vscode.nix ./zsh.nix ];

  programs = {
    home-manager.enable = true;
  };

  home = {
    username = "rafal";
    homeDirectory = "/home/rafal";

    stateVersion = "22.11";

    packages = with pkgs; [
      _1password
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

  xdg.systemDirs.data = [
    # "$HOME/.nix-profile/share"
  ];
}
