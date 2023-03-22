{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ steam protonup-ng lutris gamemode ];
}
