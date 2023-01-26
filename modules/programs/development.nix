{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    vscodium
    teams
    thunderbird
    git
    cargo
    nodejs
    python3Full
    nodePackages_latest.npm
    clang
  ];
}
