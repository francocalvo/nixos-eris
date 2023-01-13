{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [ alacritty ];

  imports = [
    ../../modules/dotfiles/i3
    ../../modules/dotfiles/fonts
    ../../modules/dotfiles/neovim
    ../../modules/dotfiles/programs
    ../../modules/dotfiles/shell
  ];

  # Paths managed by Home Manager
  home.username = "calvo";
  home.homeDirectory = "/home/calvo";
  # Basic configuration
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
