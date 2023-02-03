{ config, pkgs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/systemDesktop # Defines locale, sound, etc
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "root" "networkmanager" "audio" "video" "docker"];
    shell = pkgs.zsh;
  };

  system.stateVersion = "22.11";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };
}
