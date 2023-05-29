{ lib, pkgs, config, ... }:
with lib;
with lib.my;
let
  cfg = config.modules.d.windowManager.sway.waybar;
  audioSupport = config.modules.hardware.sound.enable;
in {
  options.modules.d.windowManager.sway.waybar.enable =
    lib.mkEnableOption "Bar for Wayland";

  config = mkIf cfg.enable {
    # Some extra scripts for easier media support
    user.packages = with pkgs; mkIf audioSupport [ pavucontrol playerctl ];

    home._ = {
      programs.waybar = {
        enable = true;
        package = pkgs.waybar.override { pulseSupport = audioSupport; };
      };

      # Waybar config
      home.file.".config/waybar" = {
        source = builtins.toPath "${config.paths.dotsDir}/waybar";
        recursive = true;
      };

    };
  };
}
