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

{ user, outputs, ... }:
let inherit (outputs) pkgs;
in {
  imports = [ ./hardware-configuration.nix ];
  nixpkgs.config.allowUnfree = true;
  programs.zsh.enable = true;

  networking.firewall.enable = false;

  # Modules
  modules.nixos = {
    gaming = {
      enable = true;
      sunshine = {
        enable = true;
        enableAvahi = true;
        disableFirewall = true;
      };
    };
    basics.enable = true;
    neovim.enable = true;
    dev = {
      enable = true;
      python = true;
      nodejs = true;
    };
  };

  # Cach for nix-gaming
  nix.settings = {
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups =
      [ "wheel" "root" "networkmanager" "audio" "video" "docker" "input" ];
    shell = pkgs.zsh;
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  hardware = {
    bluetooth.enable = true;
    opengl.enable = true;
    opengl.driSupport32Bit = true; # Enable 32 bit support for Steam
    # nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
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
      videoDrivers = [ "amdgpu" ]; # Enable just if using real PC
      deviceSection = ''
        Option "VariableRefresh" "true"
      '';
    };

    picom = {
      enable = true;
      vSync = true;
    };
    openssh.enable = true;
  };

  system.stateVersion = "22.11";
}
