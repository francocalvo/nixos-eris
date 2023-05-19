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

{ inputs, lib, pkgs, ... }:
let inherit lib;
in {
  imports = [
    # ../../modules/desktop-wm
    # ../../modules/shell
    ./hardware-configuration.nix
  ];
  nixpkgs.config.allowUnfree = true;
  programs.zsh.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_zen;
  networking.firewall.enable = false;
  #
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
  #   shell = pkgs.zsh;
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

  # Enable the X11 windowing system.
  services = {
    openssh.enable = true;
    # This allows to use MTP with Kindle, Android, etc.
    gvfs.enable = true;
    # This allows the global install of a keyring
    gnome.gnome-keyring.enable = true;
  };

  system.stateVersion = "22.11";
}
