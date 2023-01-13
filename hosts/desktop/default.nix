{ config, pkgs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/general/system.nix # Defines locale, sound, etc
    ../../modules/general/i3.nix # Defines Display and Windows manager.
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "root" "networkmanager" "audio" "video" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "22.11";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
}
