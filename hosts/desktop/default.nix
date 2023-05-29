{ inputs, lib, pkgs, ... }:
let inherit (lib.my) enable disable;
in {
  imports = [ ./hardware-configuration.nix ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  modules = {
    d = {
      terminal.alacritty = enable;
      theme.nord = enable;
      displayServer = {
        lightdm.enable = false;
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
    network = {
      network-manager = enable;
      samba.olimpo.connect = false;
    };
    hardware = { sound = enable; };
    dev = {
      python = enable;
      nodejs = enable;
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
      brave
      calibre
      discord
      firefox
      libreoffice
      spotify
      qbittorrent
      vlc
      unrar
      unzip
      zip
      which
      git
      libsForQt5.kcalc
      latexrun
      texlive.combined.scheme-full
      teams
      thunderbird
      flameshot
      cinnamon.nemo
      libsForQt5.bluedevil
    ];
  };

  # TODO: Autostart nextcloud-client
  home._ = {
    services.nextcloud-client = {
      enable = true;
      startInBackground = true;
    };
  };

  # # Modules
  # modules.nixos = {
  #   shell = "zsh";
  #   terminal = "alacritty";
  #   displayServer = {
  #     xorg.enable = true;
  #     wayland.enable = true;
  #   };
  #   gaming = {
  #     enable = true;
  #     sunshine.enable = false;
  #   };
  #   basicSoftware.enable = true;
  #   neovim.enable = true;
  #   dev = {
  #     enable = true;
  #     python = true;
  #     nodejs = true;
  #   };
  # };
  #
  # Cach for nix-gaming
  nix.settings = {
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };

  # # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.${user} = {
  #   isNormalUser = true;
  #   extraGroups =
  #     [ "wheel" "root" "networkmanager" "audio" "video" "docker" "input" ];
  # };

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

  system.stateVersion = "22.11";
}
