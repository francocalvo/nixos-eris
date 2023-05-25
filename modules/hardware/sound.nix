{ config, lib, ... }:
with lib;
let cfg = config.modules.hardware.sound;
in {
  options.modules.hardware.sound = {
    enable = lib.mkEnableOption "Connect to Olimpo samba";
  };

  config = mkIf cfg.enable {
    # Enable sound.
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
