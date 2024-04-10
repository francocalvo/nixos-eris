{ lib, pkgs, ... }:
let inherit (lib.my) enable disable;
in {
  imports = [ ./hardware-configuration.nix ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  modules = {
    d = {
      obsstudio = enable;
      terminal.alacritty = enable;
      theme.nord = enable;
      finances.enable = true;
      displayServer = {
        gdm = {
          enable = true;
          defaultSession = "sway";
        };
      };
      windowManager = {
        # xorg = enable;
        sway = enable;
      };
    };
    network = { network-manager = enable; };
    hardware = { sound = enable; };
    dev = {
      python = enable;
      nodejs = enable;
      docker = enable;
      distrobox = disable;
      virt = enable;
    };
    shell.zsh = enable;
    gaming = {
      enable = true;
      performanceTweaks = disable;
      sunshine = disable;
    };
    editors = { neovim = enable; };
    fonts = enable;
    ps5 = enable;
  };

  user = {
    packages = with pkgs; [
      bitwarden
      calibre
      discord
      libreoffice-fresh
      zulu
      spotify
      qbittorrent
      vlc
      unrar
      unzip
      zip
      which
      git
      libsForQt5.kcalc
      thunderbird
      libpng
      flameshot
      gnome.nautilus
      gnome.sushi
      libsForQt5.bluedevil
      nextcloud-client
      tealdeer
      stremio
      texliveFull
      #obs-studio
      #texlive.combined.scheme-full
      drawio
      python311Packages.beancount

      # Browsers
      firefox
      brave
      google-chrome
      teams-for-linux

      #openconnect
      #gnome.networkmanager-openconnect
      libsecret

      # Monitoring
      amdgpu_top
    ];
  };

  # TODO: Autostart nextcloud-client
  home._ = {
    services.nextcloud-client = {
      enable = true;
      startInBackground = true;
    };
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  hardware = {
    bluetooth.enable = true;
    opengl.enable = true;
    opengl.driSupport32Bit = true; # Enable 32 bit support for Steam
  };

  services = {
    openssh.enable = true;
    gvfs.enable = true; # MTP for Kindle, Android, etc
    gnome.gnome-keyring.enable = true;
  };

  programs = {
    seahorse.enable = true;
    dconf.enable = true;
  };

  system.stateVersion = "23.11";
}
