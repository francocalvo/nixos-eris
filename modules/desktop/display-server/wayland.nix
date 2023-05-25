{ lib, pkgs, config, ... }:
with lib;
with lib.my;
let cfg = config.modules.d.displayServer.sway;
in {
  options.modules.d.displayServer.sway.enable =
    lib.mkEnableOption "Wayland display server";

  config = lib.mkIf cfg.enable {
    # Enable sway itself, with few extra packages
    programs.sway = {
      enable = true;
      extraPackages = with pkgs; [ xwayland ];
    };

    user.packages = with pkgs; [
      swaybg
      autotiling
      glib
      grim
      slurp
      wl-clipboard
    ];

    # Home-manager configuration
    home._ = {
      # Sets packages used for desktop environment
      home.packages = with pkgs; [
        feh
        dconf # Needed for GTK Theming
        networkmanagerapplet
        rofi
      ];

      # programs.swaylock.enable = true;
      # wayland.windowManager.sway.enable = true;
      # services = {
      #   # Enable swayidle
      #   swayidle = { enable = true; };
      # };
      #
      # home.file.".config/sway" = {
      #   source = ../../dotfiles/i3;
      #   recursive = true;
      # };
    };
  };
}
