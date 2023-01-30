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
    python310Packages.pip
    pipenv
    nodePackages_latest.npm
    clang
  ];
}
