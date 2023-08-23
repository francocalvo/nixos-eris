{ lib, pkgs, config, ... }:
with lib;
with lib.my;
let cfg = config.modules.d.windowManager.plasma;
in {
  options.modules.d.windowManager.plasma.enable =
    mkEnableOption "Xorg display server";

  config = mkIf cfg.enable {
    services = {
      xserver = {
        enable = true;

        desktopManager.plasma5 = { enable = true; };
      };
    };

    home._ = {
      home.packages = with pkgs; [
        xwayland
        libsForQt5.bismuth
      ];
    };

  };
}
