# NixOS Configuration for my desktop. This is mainly global confugrations,
# since most programs and per user configs are managed by home-manager.
#
# The current referenced files are:
#
#  flake.nix 
#   ├─ ./hosts  
#   │   ├─ default.nix 
#   │   └─ ./desktop
#   │       ├─ ./default.nix *
#   │       └─ ./hardware-configuration.nix 
#   └  ./modules
#       └─ systemDesktop 

{ config, pkgs, user, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports = [ ./hardware-configuration.nix ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "root" "networkmanager" "audio" "video" "docker" ];
    shell = pkgs.zsh;
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  # Enable for Nvidia support
  hardware = {
    bluetooth.enable = true;
    opengl.enable = true;
    nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Enable the X11 windowing system.
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
      videoDrivers = [ "nvidia" ]; # Enable just if using real PC
    };

    picom = {
      enable = true;
      vSync = true;
    };
    openssh.enable = true;
  };

  system.stateVersion = "22.11";
}
