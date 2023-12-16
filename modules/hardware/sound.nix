{ config, lib, pkgs, ... }:
with lib;
let cfg = config.modules.hardware.sound;
in {
  options.modules.hardware.sound = {
    enable = lib.mkEnableOption "Connect to Olimpo samba";
  };

  config = mkIf cfg.enable {
    # Enable sound.
    services = {
      pipewire = {
        enable = true;
        wireplumber.enable = true;
        audio.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
      };
    };

    user.packages = with pkgs; [ pulseaudio ];

  };
}
