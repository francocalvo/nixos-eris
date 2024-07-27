{ lib, pkgs, config, ... }:
with lib;
with lib.my;
with types;
let cfg = config.modules.d.displayServer.gdm;
in {
  options.modules.d.displayServer.gdm = {
    enable = mkEnableOption "Xorg display server";
    defaultSession = mkOption {
      type = enum [ "none+13" "sway" ];
      description = "Default session";
    };
  };

  config = mkIf cfg.enable {
    services = {
      displayManager.defaultSession = cfg.defaultSession;
      xserver = {
        enable = true;
        displayManager = {
          gdm = {
            enable = true; # Wallpaper and GTK theme
            debug = true;
            wayland = true;
          };
        };
      };
    };
  };
}
