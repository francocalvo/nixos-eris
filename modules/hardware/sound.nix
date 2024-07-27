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

        extraConfig.pipewire = {
          "context.objects" = [
            {
              factory = "adapter";
              args = {
                node.name = "virtual-sink-1";
                media.class = "Audio/Sink";
                object.linger = true;
                factory.name = "support.null-audio-sink";
              };
            }
            {
              factory = "adapter";
              args = {
                node.name = "virtual-sink-2";
                media.class = "Audio/Sink";
                object.linger = true;
                factory.name = "support.null-audio-sink";
              };
            }
            {
              factory = "adapter";
              args = {
                node.name = "splitter-1";
                media.class = "Audio/Sink";
                object.linger = true;
                factory.name = "support.stream-adapter";
                node = {
                  input.node =
                    "alsa_output.usb-Logitech_G735_Gaming_Headset-01.analog-stereo"; # Replace with your real sink ID
                  output.node = "virtual-sink-1";
                };
              };
            }
            {
              factory = "adapter";
              args = {
                node.name = "splitter-2";
                media.class = "Audio/Sink";
                object.linger = true;
                factory.name = "support.stream-adapter";
                node = {
                  input.node =
                    "alsa_output.usb-Logitech_G735_Gaming_Headset-01.analog-stereo"; # Replace with your real sink ID
                  output.node = "virtual-sink-2";
                };
              };
            }
          ];
        };

      };
    };

    user.packages = with pkgs; [ pulseaudio ];

  };
}
