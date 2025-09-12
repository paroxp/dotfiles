{ pkgs, config, ... }:

let
  customOhMyZshDir = "${config.xdg.configHome}/oh-my-zsh";
  customZshDir = "${config.xdg.configHome}/zsh";
in {
  programs.zsh = {
    enable = true;
    dotDir = customZshDir;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ip = "ip --color=auto";
      ls = "ls --color=tty --human-readable";
      ping = "ping -c 5";
      update = "sudo nixos-rebuild switch";
    };

    localVariables = {
      ZSH_TMUX_AUTOSTART = true;
      ZSH_TMUX_AUTOCONNECT = true;
      ZSH_TMUX_AUTOQUIT = true;
      ZSH_TMUX_CONFIG = "$HOME/.config/tmux/tmux.conf";
      ZSH_TMUX_ITERM2 = pkgs.stdenv.isDarwin;
    };

    history = {
      ignoreDups = true;
      path = "${customZshDir}/history";
      size = 10000;
    };

    oh-my-zsh = {
      enable = true;
      custom = customOhMyZshDir;
      plugins = [
        "tmux"
      ];
    };

    plugins = with pkgs; [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
        };
      }
    ];
  };
}
