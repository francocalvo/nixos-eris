# This should be the NixOS config for most devices I'll use.
#
# The current referenced files are:
#
#  flake.nix 
#   └─ ./hosts  
#       ├─ default.nix 
#       └─ configuration.nix *

{ config, pkgs, lib, inputs, ... }: {

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

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiInstallAsRemovable = true;
    efiSupport = true;
    useOSProber = true;
  };

  boot.supportedFilesystems = [ "ext4" "fat" "ntfs" ];

  # Docker configuration
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    liveRestore = false;
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [ "--all" ];
    };
  };

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
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
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.wine-ge # installs a package
  ];

  # Select internationalisation properties.
  i18n.defaultLocale = "es_AR.UTF-8";

  # Set your time zone.
  time.timeZone = "America/Argentina/Cordoba";

  # This allows to use MTP with Kindle, Android, etc.
  services = { gvfs.enable = true; };

  # This allows the global install of a keyring
  services.gnome.gnome-keyring.enable = true;

  fonts.fonts = with pkgs; [
    font-awesome
    font-awesome_5 # Used for polybar
    corefonts
    fira-code
    nerdfonts
    noto-fonts
    roboto
    source-code-pro
    material-icons
    material-design-icons
    meslo-lgs-nf # Needed for OMZ+P10K
    nordzy-icon-theme
    (nerdfonts.override { # Nerdfont Icons override
      fonts = [ "FiraCode" ];
    })
  ];
}
