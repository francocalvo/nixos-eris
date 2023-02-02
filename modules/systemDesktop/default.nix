{ config, pkgs, lib, ... }:
# Set your time zone.
{
  time.timeZone = "America/Argentina/Cordoba";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_AR.UTF-8";

  # Unfree Software
  nixpkgs.config.allowUnfree = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiInstallAsRemovable = true;
    efiSupport = true;
    useOSProber = true;
  };

  # Keep the system updated
  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
  };

  # Keep the system clean
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  # Networking with NetworkManager 
  networking = {
    hostName = "nixos"; # Define your hostname.
    firewall.checkReversePath = false; # This is important for the VPN
    networkmanager.enable = true;
  };

  # Wireguard configuration
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_5_4.wireguard
    wireguard-tools
  ];
  # boot.extraModulePackages = [ config.boot.kernelPackages.wireguard ];

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

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

  # This allows to use MTP with Kindle, Android, etc.
  services = { gvfs.enable = true; };

}
