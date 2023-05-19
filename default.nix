{ config, inputs, lib, pkgs, ... }:

let inherit (lib) my;
in {
  imports = [ inputs.home-manager.nixosModules.home-manager ]
    ++ my.mapModulesRec' ./modules import;

  # ‹nix flake check› bypasses, can be changed in the actual hosts
  # config, useful for testing

  nix = {
    autoOptimiseStore = true;
    extraOptions = "experimental-features = nix-command flakes";
    binaryCaches = [ "https://nix-community.cachix.org" ];
    binaryCachePublicKeys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # Use the GRUB 2 boot loader.
  boot.loader.grub = {
    enable = true;
    efiInstallAsRemovable = true;
    efiSupport = true;
    devices = [ "nodev" ];
    useOSProber = true;
  };

  environment.systemPackages = with pkgs; [ curl git wget neovim ];

  i18n.defaultLocale = "en_US.UTF-8";
}
