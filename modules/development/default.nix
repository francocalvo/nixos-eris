{ config, pkgs, ... }:

{
  imports = [ ./nodejs.nix ./python.nix ];

  home.packages = with pkgs; [ git zathura dbeaver clang ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.zsh.enable = true;
}
