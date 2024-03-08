{ pkgs, lib, config, ... }:
with lib;
with lib.my;
let cfg = config.modules.d.obsstudio;
in {
  options.modules.d.obsstudio = {
    enable = mkEnableOption "Enable OBS and plugins";
  };

  config = mkIf cfg.enable {
    home._ = {
      programs.obs-studio = {
        enable = true;
        package = pkgs.obs-studio;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-pipewire-audio-capture
        ];
      };
    };
  };
}
