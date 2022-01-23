{ config, lib, pkgs, ... }:

with lib;

let cfg = config.modules.common; in {
  options.modules.common = {
    enable = mkEnableOption "common module";
    extraPackages = mkOption {
      type = types.listOf types.str;
      default = [ ];
    };
    ssh = {
      enable = mkOption {
        type = types.bool;
        default = true;
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (vim_configurable.override { python = python3; })

      bash
      curl
      git
      git
      gnupg
      man
      p7zip
      pinentry
      tmux
      tree
      wget
      zsh

      bmon
      htop
      nmap
    ] ++ cfg.extraPackages;

    programs = {
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };

      nano.nanorc = ''
        set tabstospaces
        set tabsize 2
        set autoindent
        set smarthome
        set linenumbers
      '';

      tmux = {
        enable = true;
        keyMode = "vi";
        terminal = "tmux-256color";
        clock24 = true;
      };

      zsh = {
        enable = true;
        autosuggestions.enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
      };
    };

    # Enable SSH with password authentication disabled.
    services = {
      fail2ban.enable = true;

      openssh = {
        enable = cfg.ssh.enable;
        allowSFTP = true;
        passwordAuthentication = false;
      };
    };
  };
}
