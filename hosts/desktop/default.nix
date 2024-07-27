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
    ps5 = disable;
  };

  user = {
    packages = with pkgs; [
      bitwarden
      calibre
      discord
      onlyoffice-bin_latest
      spotify
      qbittorrent
      vlc
      unrar
      unzip
      zip
      which
      git
      libsForQt5.kcalc
      libpng
      flameshot
      nautilus
      sushi
      libsForQt5.bluedevil
      nextcloud-client
      tealdeer
      stremio

      texlive.combined.scheme-full
      python311Packages.beancount

      # Browsers
      firefox
      brave
      teams-for-linux

      #openconnect
      #gnome.networkmanager-openconnect
      libsecret

      # Monitoring
      amdgpu_top

      racket
    ];
  };

  xdg.mime.defaultApplications = {
    "application/pdf" = "firefox.desktop";
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };

  # TODO: Autostart nextcloud-client
  home._ = {
    services.nextcloud-client = {
      enable = true;
      startInBackground = true;
    };
  };

  nix = { extraOptions = "experimental-features = nix-command flakes"; };

  hardware = {
    bluetooth.enable = true;
    # opengl.enable = true;
    # opengl.driSupport32Bit = true; # Enable 32 bit support for Steam
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  services = {
    openssh.enable = true;
    gvfs.enable = true; # MTP for Kindle, Android, etc
    gnome.gnome-keyring.enable = true;
    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="pci", DRIVER=="pcieport", ATTR{power/wakeup}="disabled"
    '';
  };

  programs = {
    seahorse.enable = true;
    dconf.enable = true;
  };

  system.stateVersion = "23.11";
}
