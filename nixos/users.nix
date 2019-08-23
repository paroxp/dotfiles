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
          "video"
          "wheel"
        ];
        group = "users";
        home = "/home/rafal";
        isNormalUser = true;
        shell = pkgs.zsh;
      };
  };

}
