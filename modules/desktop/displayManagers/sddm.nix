{ lib, pkgs, config, ... }:
with lib;
with lib.my;
with types;
let cfg = config.modules.d.displayServer.sddm;
in {
  options.modules.d.displayServer.sddm = {
    enable = mkEnableOption "Xorg display server";
    defaultSession = mkOption {
      type = enum [ "none+13" "sway" ];
      description = "Default session";
    };
  };

  config = mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;
        displayManager = {
          sddm = {
            enable = true; # Wallpaper and GTK theme
          };
          defaultSession = cfg.defaultSession;
        };
      };
    };
  };
}
