{ config, pkgs, ... }:

{
  # Sets packages used for desktop environment
  home.packages = with pkgs; [
    feh
    flameshot
    cinnamon.nemo
    dconf # Needed for GTK Theming
    networkmanagerapplet
    rofi
    libsForQt5.bluedevil
  ];

  home.file.".config/i3" = {
    source = ../../dotfiles/i3;
    recursive = true;
  };

  home.file.".config/polybar" = {
    source = ../../dotfiles/polybar;
    recursive = true;
  };

  home.file.".config/polybar/launch.sh" = {
    source = ../../dotfiles/polybar/launch.sh;
    executable = true;
  };

  services = {
    polybar = {
      enable = true;
      script = (builtins.readFile ../../dotfiles/polybar/launch.sh);
      package = pkgs.polybar.override {
        i3Support = true;
        pulseSupport = true;
      };
    };
  };

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
}
