{ config, pkgs, inputs, ... }:

{

  home.packages = with pkgs; [
    steam
    protonup-ng
    lutris
    gamemode
    inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.wine-ge # installs a package
    winetricks
    bottles
  ];
}
