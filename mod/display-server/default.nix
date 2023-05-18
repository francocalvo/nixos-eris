{ outputs, config, lib, ... }:
with lib;
let
  inherit (outputs) pkgs user;
  cfg = config.modules.nixos.displayServer;
in {
  imports = [ ./xorg.nix ./wayland.nix ];

  options.modules.nixos.displayServer = {
    xorg.enable = mkEnableOption "Use Xorg as display server";
    wayland.enable = mkEnableOption "Use Wayland as display server";
  };

  config = lib.mkMerge [
    ################### common ###################
    {
      home-manager.users.${user} = {
        home.pointerCursor =
          { # This will set cursor system-wide so applications can not choose their own
            gtk.enable = true;
            name = "Nordzy-cursors";
            package = pkgs.nordzy-cursor-theme;
            size = 16;
          };

        gtk = { # Theming
          enable = true;
          theme = {
            name = "Nordic";
            package = pkgs.nordic;
          };
          iconTheme = {
            name = "Nordzy-green";
            package = pkgs.nordzy-icon-theme;
          };
          font = {
            name = "FiraCode Nerd Font:style=Regular";
          }; # Cursor is declared under home.pointerCursor
        };
      };
    }

    #################### xorg #####################
    (lib.mkIf cfg.xorg.enable {
      modules.internal.displayServer.xorg.enable = true;
    })

    ################### wayland ###################
    (lib.mkIf cfg.wayland.enable {
      modules.internal.displayServer.wayland.enable = true;
    })
  ];
}
