{ lib, pkgs, config, ... }:
with lib;
with lib.my;
let cfg = config.modules.d.windowManager.sway;
in {
  options.modules.d.windowManager.sway.enable =
    lib.mkEnableOption "Wayland display server";

  config = lib.mkIf cfg.enable {
    # security.polkit.enable = true;
    # security.rtkit.enable = true;

    # Implicitly enable waybar
    modules.d.windowManager.sway.waybar.enable = true;

    xdg.portal = {
      enable = true;
      wlr.enable = true;

      # gtk portal needed to make gtk apps happy
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];

      config = {
        sway = {
          default = [ "gtk" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
          "org.freedesktop.impl.portal.Screencast" = [ "wlr" ];
        };

        common = {
          default = [ "gtk" ];
          "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
          "org.freedesktop.impl.portal.Screencast" = [ "wlr" ];
        };
      };
    };

    programs = {
      sway = {
        enable = true;
        wrapperFeatures.base = true;
        wrapperFeatures.gtk = true;

        # Execute just before Sway
        extraSessionCommands = ''
          export SDL_VIDEODRIVER=wayland
          export QT_QPA_PLATFORM=wayland-egl
          export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
          export _JAVA_AWT_WM_NONREPARENTING=1
          export XDG_CURRENT_DESKTOP=sway
          export XDG_SESSION_DESKTOP=sway
          export XDG_SESSION_TYPE=wayland
          export GDK_BACKEND=wayland
          export MOZ_ENABLE_WAYLAND=1
          export MOZ_USE_XINPUT2=1
          export WLR_DRM_NO_MODIFIERS=1
          export NIXOS_OZONE_WL=1
        '';
      };
    };

    home._ = {
      home.packages = with pkgs; [
        swaybg
        autotiling
        glib
        grim
        wlr-randr
        wdisplays
      ];

      # home.sessionVariables = {
      #   SDL_VIDEODRIVER = "wayland";
      #   QT_QPA_PLATFORM = "wayland-egl";
      #   QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      #   _JAVA_AWT_WM_NONREPARENTING = 1;
      #   XDG_CURRENT_DESKTOP = "sway";
      #   XDG_SESSION_DESKTOP = "sway";
      #   XDG_SESSION_TYPE = "wayland";
      #   GDK_BACKEND = "wayland";
      #   MOZ_ENABLE_WAYLAND = 1;
      #   MOZ_USE_XINPUT2 = 1;
      #   WLR_DRM_NO_MODIFIERS = 1;
      #   NIXOS_OZONE_WL = 1;
      # };

      wayland.windowManager.sway = { xwayland = true; };

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
