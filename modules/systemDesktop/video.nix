{ config, pkgs, lib, ... }: {
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
        extraPackages = with pkgs; [ ];
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
}
