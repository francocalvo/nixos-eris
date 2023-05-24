{ lib, config, pkgs, options, ... }:
with lib;
with lib.my;
let cfg = config.modules.fonts;
in {

  options.modules.fonts.enable = mkEnableOption "Set up more fonts";

  # TODO: This should be improved
  config = mkIf cfg.enable {
    fonts.fonts = with pkgs; [
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
      (nerdfonts.override { # Nerdfont Icons override
        fonts = [ "FiraCode" ];
      })
    ];
  };
}
