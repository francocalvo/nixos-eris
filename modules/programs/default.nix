{ config, pkgs, ... }:
{
  imports = [
    ./personal.nix
    ./development.nix
  ];
}
