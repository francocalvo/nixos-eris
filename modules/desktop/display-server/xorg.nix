{ lib, pkgs, config, ... }:
with lib;
with lib.my;
let cfg = config.modules.d.displayServer.xorg;
in {
  options.modules.d.displayServer.xorg.enable =
    mkEnableOption "Xorg display server";

  config = mkIf cfg.enable {
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
    home._ = {
      # Sets packages used for desktop environment
      home.packages = with pkgs; [
        feh
        dconf # Needed for GTK Theming
        networkmanagerapplet
        rofi
      ];

      home.file.".config/i3" = {
        source = builtins.toPath "${config.paths.dotsDir}/i3";
        recursive = true;
      };

      home.file.".config/polybar" = {
        source = builtins.toPath "${config.paths.dotsDir}/polybar";
        recursive = true;
      };

      home.file.".config/polybar/launch.sh" = {
        source = builtins.toPath "${config.paths.dotsDir}/polybar/launch.sh";
        executable = true;
      };

      services = {
        polybar = {
          enable = true;
          script = (builtins.readFile
            (builtins.toPath "${config.paths.dotsDir}/polybar/launch.sh"));
          package = pkgs.polybar.override {
            i3Support = true;
            pulseSupport = true;
          };
        };
      };

    };
  };
}
