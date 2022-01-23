{ lib, ... }:

{
  options = with lib; {
    allowUnfree = mkOption {
      type = types.bool;
      default = false;
    };
    cpu = mkOption {
      type = types.enum [ "amd" "intel" ];
      default = "intel";
    };
    hidpi = mkOption {
      type = types.bool;
      default = true;
    };
    host = {
      domain = mkOption {
        type = types.str;
        default = "";
      };
      id = mkOption {
        type = types.str;
        default = "";
      };
      name = mkOption {
        type = types.str;
        default = "";
      };
    };
  };
}
