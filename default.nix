{ config, inputs, lib, pkgs, ... }:

let inherit (lib) my;
in {
  imports = [ inputs.home-manager.nixosModules.home-manager ]
    ++ my.mapModulesRec' ./modules import;

  # Keep the system clean
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  # Keep the system updated
  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
  };

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    efiInstallAsRemovable = true;
    efiSupport = true;
    devices = [ "nodev" ];
    useOSProber = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  # Base packages
  environment.systemPackages = with pkgs; [
    bind
    cached-nix-shell
    git
    curl
    vim
    neovim
    wget
    gnumake
    unzip
  ];
}
