{ config, pkgs, ... }:

{

  home.packages = with pkgs; [ python3Full python310Packages.pip pipenv ];

}
