{ pkgs }:

{
  allowUnfree = true;

  build = {
    developer.enable = true;
    gamer.enable = true;
  };

  desktopEnvironment = {
    kde.enable = true;
  };
}
