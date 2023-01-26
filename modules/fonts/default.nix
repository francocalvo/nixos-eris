{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
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
    nordzy-icon-theme
  ];

}
