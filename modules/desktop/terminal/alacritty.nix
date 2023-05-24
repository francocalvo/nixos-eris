{ pkgs, lib, config, ... }:
with lib;
with lib.my;
let cfg = config.modules.d.terminal.alacritty;
in {
  options.modules.d.terminal.alacritty = {
    enable = mkEnableOption "Use Alacritty as default terminal emulator";
  };

  config = mkIf cfg.enable {

    # fonts.fonts = with pkgs; [ meslo-lgs-nf ];

    home._ = {
      programs.alacritty = {
        enable = true;
        settings = { font = { normal = { family = "MesloLGS NF"; }; }; };
      };
    };
  };
}
