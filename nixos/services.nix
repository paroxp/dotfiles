{ config, pkgs, ... }:

{
  services.openssh.enable = true;
  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization pkgs.libu2f-host ];

  services.xserver = {
    enable = true;
    autorun = true;
    desktopManager.xfce.enable = true;
    displayManager.lightdm.enable = true;
    layout = "us";
    videoDrivers = [ "nvidia" ];
    
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
          compton
          dunst
          feh
          i3lock
          lxappearance
          (polybar.override { i3GapsSupport = true; githubSupport = true; })
          python3
          python3Packages.dbus-python
          rofi
          termite
      ];
      package = pkgs.i3-gaps;
    };
  };

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
}
