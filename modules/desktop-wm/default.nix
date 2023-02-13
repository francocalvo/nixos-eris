{ config, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      displayManager = {
        lightdm.enable = true;
        defaultSession = "none+i3";
      };
      windowManager.i3 = {
        enable = true;
        #extraPackages = with pkgs; [ ];
      };
      layout = "latam";
      xkbOptions = "caps:escape"; # map caps to escape.
      videoDrivers = [ "nvidia" ]; # Enable just if using real PC
    };

    picom = {
      enable = true;
      vSync = true;
    };
    openssh.enable = true;
  };

  # Enable just if using real PC
  hardware = {
    opengl.enable = true;
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Sets packages used for desktop environment
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
}
