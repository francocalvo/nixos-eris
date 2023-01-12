{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    dejavu_fonts
    font-awesome
    corefonts
    fira-code
    nerdfonts
    noto-fonts
    roboto
    source-code-pro
    material-icons
  ];

}
