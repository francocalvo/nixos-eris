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

{ config, pkgs, user, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "root" "networkmanager" "audio" "video" "docker" ];
    shell = pkgs.zsh;
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  system.stateVersion = "22.11";
}
