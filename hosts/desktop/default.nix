{ lib, pkgs, ... }:
let inherit (lib.my) enable disable;
in {
  imports = [ ./hardware-configuration.nix ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  modules = {
    d = {
      terminal.alacritty = enable;
      theme.nord = enable;
      finances = enable;
      displayServer = {
        sddm = {
          enable = true;
          defaultSession = "sway";
        };
      };
      windowManager = {
        xorg = enable;
        sway = enable;
      };
    };
    network = { network-manager = enable; };
    hardware = { sound = enable; };
    dev = {
      python = enable;
      nodejs = enable;
      docker = enable;
      virt = enable;
    };
    shell.zsh = enable;
    gaming = {
      enable = true;
      performanceTweaks = enable;
      sunshine = disable;
    };
    editors = { neovim = enable; };
    fonts = enable;
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
      teams
      thunderbird
      flameshot
      gnome.nautilus
      gnome.sushi
      libsForQt5.bluedevil
      nextcloud-client
      tealdeer
      stremio

      obs-studio
      texlive.combined.scheme-full

      # Browsers
      brave
      firefox
      firefox-unwrapped
      microsoft-edge-dev
      chromium

      openconnect
      gnome.networkmanager-openconnect
      libsecret

      # Monitoring
      amdgpu_top
      arandr
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

  system.stateVersion = "23.05";
}
