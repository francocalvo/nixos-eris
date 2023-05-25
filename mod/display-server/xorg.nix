{ outputs, config, ... }:
let
  inherit (outputs) pkgs user;
  inherit (pkgs) lib;
  cfg = config.modules.internal.displayServer.xorg.enable;
in {
  options.modules.internal.displayServer.xorg.enable =
    lib.mkEnableOption "Xorg display server";

  config = lib.mkIf cfg {
    services = {
      xserver = {
        enable = true;
        displayManager = {
          lightdm = {
            enable = true; # Wallpaper and GTK theme
            background =
              pkgs.nixos-artwork.wallpapers.nineish-dark-gray.gnomeFilePath;
            greeters = {
              gtk = {
                theme = {
                  name = "Nordic";
                  package = pkgs.nordic;
                };
                cursorTheme = {
                  name = "Nordic-cursors";
                  package = pkgs.nordic;
                  size = 16;
                };
              };
            };
          };
          defaultSession = "none+i3";
        };
        windowManager.i3 = {
          enable = true;
          extraPackages = with pkgs; [ nordic ];
        };
        layout = "latam";
        xkbOptions = "caps:escape"; # map caps to escape.
        videoDrivers = [ "amdgpu" ]; # Enable just if using real PC
        deviceSection = ''
          Option "VariableRefresh" "true"
        '';
      };

      picom = {
        enable = true;
        vSync = true;
      };
    };

    # Home-manager configuration
    home-manager.users.${user} = {
      # Sets packages used for desktop environment
      home.packages = with pkgs; [
        feh
        dconf # Needed for GTK Theming
        networkmanagerapplet
        rofi
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

    };
  };
}
