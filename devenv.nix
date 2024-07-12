{ pkgs, ...}:

{
  home.packages = with pkgs; [
    pkgs.devenv
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
}
