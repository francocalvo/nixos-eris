{ pkgs, config, lib, ... }:
with lib;
with lib.my;
let cfg = config.modules.d.theme.nord;
in {
  options.modules.d.theme.nord = {
    enable = mkEnableOption "Nord theme";
  };

  config = mkIf cfg.enable {
    home._ = {
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
  };

}
