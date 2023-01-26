{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [ alacritty ];

  imports = [
    ../../modules/i3
    ../../modules/fonts
    ../../modules/neovim
    ../../modules/programs
    ../../modules/shell
  ];

  # Paths managed by Home Manager
  home.username = "calvo";
  home.homeDirectory = "/home/calvo";
  # Basic configuration
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
