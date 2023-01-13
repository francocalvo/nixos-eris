{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # dejavu_fonts
    font-awesome
    font-awesome_5 # Used for polybar
    corefonts
    fira-code
    nerdfonts
    noto-fonts
    roboto
    source-code-pro
    material-icons
    material-design-icons
    meslo-lgs-nf # Needed for OMZ+P10K
    # papirus-icon-theme  # Can be used for rofi
    nordzy-icon-theme
  ];

}
