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
  imports = [
    ./hardware-configuration.nix
    ../../modules/systemDesktop # Defines locale, sound, etc
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "root" "networkmanager" "audio" "video" "docker" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "22.11";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
}
