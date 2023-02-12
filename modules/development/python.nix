{ config, pkgs, ... }:

{

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [ python3Full python310Packages.pip pipenv ];

}
