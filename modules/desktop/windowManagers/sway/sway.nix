{ lib, pkgs, config, ... }:
with lib;
with lib.my;
let cfg = config.modules.d.windowManager.sway;
in {
  options.modules.d.windowManager.sway.enable =
    lib.mkEnableOption "Wayland display server";

  config = lib.mkIf cfg.enable {
    security.polkit.enable = true;

    # Implicitly enable waybar
    modules.d.windowManager.sway.waybar.enable = true;

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      # gtk portal needed to make gtk apps happy
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-wlr
      ];
    };

    programs = {
      sway = {
        enable = true;
        extraSessionCommands = ''
          export _JAVA_AWT_WM_NONREPARENTING=1
          export QT_QPA_PLATFORM=wayland
          export XDG_CURRENT_DESKTOP=sway
          export XDG_SESSION_DESKTOP=sway
          export MOZ_ENABLE_WAYLAND=1
        '';
      };
    };

    home._ = {
      home.packages = with pkgs; [
        swaybg
        autotiling
        glib
        wl-clipboard
        xwayland
        xdg-desktop-portal
        xdg-desktop-portal-wlr
        grim
      ];

      xdg.configFile = {
        "wofi/config".text = ''
          allow_images=true
          insensitive=true
          location=center
        '';
        "wofi/style.css".source = ./wofi.css;
      };

      programs = { wofi = enable; };

      home.file.".config/sway" = {
        source = builtins.toPath "${config.paths.dotsDir}/sway";
        recursive = true;
      };
    };
  };
}
