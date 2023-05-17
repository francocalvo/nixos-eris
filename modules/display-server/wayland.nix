{ outputs, config, ... }:
let
  inherit (outputs) pkgs user;
  inherit (pkgs) lib;
  cfg = config.modules.internal.displayServer.wayland.enable;
in {
  options.modules.internal.displayServer.wayland.enable =
    lib.mkEnableOption "Wayland display server";

  config = lib.mkIf cfg {
    # Enable sway itself, with few extra packages
    programs.sway = {
      enable = true;
      # remove dmenu and rxvt-unicode from extraPackages
      extraPackages = with pkgs; [ xwayland ];
    };

    users.users.${user}.packages = with pkgs; [
      swaybg
      autotiling
      glib
      grim
      slurp
      wl-clipboard
    ];

    # Home-manager configuration
    home-manager.users.${user} = {
      # Sets packages used for desktop environment
      home.packages = with pkgs; [
        feh
        dconf # Needed for GTK Theming
        networkmanagerapplet
        rofi
      ];

      programs.swaylock.enable = true;
      wayland.windowManager.sway.enable = true;
      services = {
        # Enable swayidle
        swayidle = { enable = true; };
      };

      home.file.".config/sway" = {
        source = ../../dotfiles/i3;
        recursive = true;
      };
    };
  };
}
