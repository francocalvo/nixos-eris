{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    python3Full
    python310Packages.pip
    pipenv
    python310Packages.flake8
    python310Packages.pandas
  ];

}
