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

    gtk.iconCache.enable = false;

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;

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
        xorg.libX11
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

      programs.fuzzel = {
        enable = true;
        package = pkgs.fuzzel;
        settings = {
          "main" = {
            font = "FiraCode Nerd Font:style=Regular";
            prompt = "❯ ";
            width = 70;
            icon-theme = "Nordzy-green";
            icons-enabled = true;
            horizontal-pad = 30;
            vertical-pad = 30;
            inner-pad = 5;
            line-height = 25;
            letter-spacing = 0.5;
          };
          "colors" = {
            background = "#2e3440f8";
            text = "#e5e9f0f8";
            match = "#88c0d0f8";
            border = "#88c0d0f8";
            selection = "#88c0d0f8";
            selection-text = "#2e3440f8";
            selection-match = "#2e3440f8";
          };
          "border" = {
            width = 1;
            radius = 0;
          };
        };
      };

      home.file.".config/sway" = {
        source = builtins.toPath "${config.paths.dotsDir}/sway";
        recursive = true;
      };
    };
  };
}
