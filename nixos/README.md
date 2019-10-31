# Usage

* Setup a new configuration for the machinee or re-use the existing config
* Link the configuration file, to `local-configuration.nix`
  ```
  ln -s build.configuration.nix local-configuration.nix
  ```
* Run `nix-install` or `nixos-rebuild` to build from configuration

