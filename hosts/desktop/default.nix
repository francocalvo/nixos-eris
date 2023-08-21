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
        lightdm.enable = false;
        gdm = {
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
    };
    shell.zsh = enable;
    gaming = {
      enable = true;
      performanceTweaks = disable;
      sunshine = disable;
    };
    editors = { neovim = enable; };
    fonts = enable;
  };

  user = {
    packages = with pkgs; [
      bitwarden
      brave
      calibre
      discord
      firefox
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
      # latexrun
      # texlive.combined.scheme-full
      teams
      thunderbird
      flameshot
      cinnamon.nemo
      gnome.nautilus
      gnome.sushi
      libsForQt5.bluedevil
      nextcloud-client
      microsoft-edge-dev
      librecad
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

  system.stateVersion = "23.05";
}
