{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    feh
    flameshot
    cinnamon.nemo
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

  #Basic configuration
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}