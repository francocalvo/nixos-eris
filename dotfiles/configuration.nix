{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiInstallAsRemovable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

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
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Argentina/Cordoba";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_AR.UTF-8";

  # Enable the X11 windowing system.
  services = {
    xserver = {
      enable = true;
      displayManager = {
        lightdm.enable = true;
        defaultSession = "none+i3";
      };
      windowManager.i3.enable = true;
      xkb = {
        layout = "latam";
        options = "caps:escape"; # map caps to escape.
      };
      videoDrivers = [ "amdgpu" ]; # Enable just if using real PC
    };

    picom = {
      enable = true;
      vSync = true;
      backend = "glx";
      fade = true;
      inactiveOpacity = 0.8;
      settings = ''
        unredir-if-possible = false
      '';

    };

    openssh.enable = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.calvo = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "root"
      "networkmanager"
      "audio"
      "video"
      "input"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      alacritty
      feh
      firefox
      flameshot
      git
      neovim
      brave
      cinnamon.nemo
      gnome.nautilus
      gnome.sushi
      #cinnamon.nemo-fileroller
      networkmanagerapplet
      nodejs
      nodePackages_latest.npm
      oh-my-zsh
      python3Full
      tree
      zip
      which
      vlc
      unrar
      unzip
    ];
  };

  system.stateVersion = "23.05";

}
