{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    nodejs
    nodePackages_latest.npm
    yarn
  ];

}
