{ lib, pkgs, config, ... }:
with lib;
with lib.my;
let cfg = config.modules.d.displayServer.sway;
in {
  options.modules.d.displayServer.sway.enable =
    lib.mkEnableOption "Wayland display server";

  config = lib.mkIf cfg.enable {
    # Enable sway itself, with few extra packages
    programs.sway = {
      enable = true;
      extraPackages = with pkgs; [ xwayland ];
    };

    user.packages = with pkgs; [
      swaybg
      autotiling
      glib
      grim
      slurp
      wl-clipboard
    ];

    home._ = {
      home.file.".config/sway" = {
        source = builtins.toPath "${config.paths.dotsDir}/sway";
        recursive = true;
      };
    };
  };
}
