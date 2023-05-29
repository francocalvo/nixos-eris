{ lib, pkgs, config, ... }:
with lib;
with lib.my;
with types;
let cfg = config.modules.d.displayServer.lightdm;
in {
  options.modules.d.displayServer.lightdm = {
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
          lightdm = {
            enable = true; # Wallpaper and GTK theme
            background =
              pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
            greeters = {
              gtk = {
                theme = {
                  name = "Nordic";
                  package = pkgs.nordic;
                };
                cursorTheme = {
                  name = "Nordic-cursors";
                  package = pkgs.nordic;
                  size = 16;
                };
              };
            };
          };
          defaultSession = cfg.defaultSession;
        };
      };
    };
  };
}
