{ config, pkgs, lib, ... }: {

  # Networking with NetworkManager 
  networking = {
    hostName = "nixos"; # Define your hostname.
    firewall.checkReversePath = false; # This is important for the VPN
    networkmanager.enable = true;
  };

  # Wireguard configuration
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_5_4.wireguard
    wireguard-tools
  ];
  # boot.extraModulePackages = [ config.boot.kernelPackages.wireguard ];
}
