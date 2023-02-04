{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    nodejs
    nodePackages_latest.npm
    yarn
    # nodePackages_latest.prisma
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.zsh.enable = true;
}
