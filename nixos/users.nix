{ config, pkgs, ... }:

{
  users = {
    mutableUsers = config.modules.desktop.enable;

    groups = {
      storage = {};
    };

    users = {
      root = {
        shell = pkgs.zsh;
      };

      rafal = {
        createHome = true;
        description = "Rafal Proszowski";
        extraGroups = [
          "adm"
          "audio"
          "disk"
          "docker"
          "jellyfin"
          "networkmanager"
          "storage"
          "users"
          "video"
          "wheel"
        ];
        openssh.authorizedKeys.keys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCxpPhGmoqD3T/K00eGcB4EUAQg4QszGDUg7uZ+Gz9m/mzzFCnLrq7sOs8S2UILPB4MgsiVtTUsSYx+sZ4ubkoJfsyp9Gzi/G3DvLpLrjt4n+IufvK2vuxtLwKKeIIg6GqGO6wBD+2vR+6VymFvhA75AOyUR4MRnUNnluU5+u01tErjUPS6rkKOMHm0a+xJMXImRZF3bbWaABJWPGG76OdUEfkkNh0vkHQ67zGRRcpqYCo9GeCi6udjZ76yEaItE/mSr25Y0FFuyTZQekvPe+zxwyi72pIx6a1KoTO5n/w3phlwVrjFX8kguaGWHUXOA/rOAxIif1Xm4H6uffM4aE7R"
        ];
        isNormalUser = true;
        shell = pkgs.zsh;
      };
    };
  };

  security = {
    sudo.wheelNeedsPassword = false;
  };
}
