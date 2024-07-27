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
      displayManager.defaultSession = cfg.defaultSession;
      xserver = {
        enable = true;
        displayManager = {
          lightdm = {
            enable = true; # Wallpaper and GTK theme
            extraConfig = ''
              display-setup-script=xrandr --output HDMI-1 --primary
            '';
            background =
              pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
            greeters = { slick = { enable = true; }; };
          };
        };
      };
    };
  };
}
