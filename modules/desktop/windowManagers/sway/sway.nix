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

    programs = { sway = { enable = true; }; };

    xdg.portal = {
      enable = true;
      # gtk portal needed to make gtk apps happy
      extraPortals = with pkgs; [ xdg-desktop-portal-wlr ];
    };

    home._ = {
      home.packages = with pkgs; [
        swaybg
        autotiling
        slurp
        glib
        wl-clipboard
        xdg-desktop-portal
        grim
        wdisplays
        wlr-randr
      ];

      wayland.windowManager.sway = {
        enable = true;
        # nVidia support
        wrapperFeatures = {
          base = false;
          gtk = false;
        };
        xwayland = true;
      };

      home.sessionVariables = {
        GDK_BACKEND = "wayland";
        MOZ_ENABLE_WAYLAND = "1";
        MOZ_USE_XINPUT2 = "1";
        WLR_DRM_NO_MODIFIERS = "1";
        # QT_QPA_PLATFORM = "wayland";
        QT_QPA_PLATFORM = "xcb";

        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "sway";

        # Used to inform discord and other apps that we are using wayland
        NIXOS_OZONE_WL = "1";
      };

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
