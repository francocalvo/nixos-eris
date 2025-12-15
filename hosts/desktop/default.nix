{ lib, pkgs, ... }:
let
  inherit (lib.my) enable disable;
in
{
  imports = [ ./hardware-configuration.nix ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  networking.firewall = {
    allowedTCPPorts = [ 5201 ];
    allowedUDPPorts = [ 5201 ];
  };

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
    network = {
      network-manager = enable;
    };
    hardware = {
      sound = enable;
    };
    dev = {
      python = enable;
      nodejs = enable;
      docker = enable;
      distrobox = disable;
      virt = disable;
      scheme = enable;
    };
    shell.zsh = enable;
    gaming = {
      enable = true;
      performanceTweaks = disable;
      sunshine = enable;
    };
    editors = {
      neovim = enable;
    };
    fonts = enable;
    ps5 = disable;
  };

  user = {
    packages = with pkgs; [
      bitwarden-desktop
      calibre
      onlyoffice-desktopeditors
      qbittorrent
      vlc
      unrar
      unzip
      zip
      which
      git
      kdePackages.kcalc
      libpng
      flameshot
      nautilus
      sushi
      kdePackages.bluedevil
      tealdeer
      cachix

      # texlive.combined.scheme-full
      python312Packages.beancount

      # Browsers
      firefox
      libsecret

      # Monitoring
      amdgpu_top
      racket
      tmux
      vulkan-tools
      gpu-viewer

      mesa
      libva
      libva-utils
      libavif

      claude-code
      gnumake
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

  nix = {
    extraOptions = "experimental-features = nix-command flakes";
  };

  hardware = {
    bluetooth.enable = true;
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        mesa
        libva
        libva-utils
        libavif
      ];
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

  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  system.stateVersion = "23.11";
}
