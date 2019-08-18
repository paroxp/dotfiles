{ pkgs, ... }:

{
    users.users = {
      rafal = {
        createHome = true;
        description = "Rafal Proszowski";
        extraGroups = [
          "audio"
          "docker"
          "games"
          "networkmanager"
          "users"
          "video"
          "wheel"
        ];
        group = "rafal";
        home = "/home/rafal";
        isNormalUser = true;
        shell = pkgs.zsh;
      };
  };

}
