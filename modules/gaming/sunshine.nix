{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.gaming.sunshine;
in
{
  options.modules.gaming.sunshine = {
    enable = mkEnableOption "Enable Sunshine for game streaming";
  };

  config = mkIf cfg.enable {
    warnings = [
      ''
        You have enabled sunshine which needs to disable the firewall and add a
        wrapper to run sunshine as root. This is a security risk and you should 
        only enable this if you know what you are doing.
      ''
    ];

    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;

      # applications = {
      #   env = {
      #     PATH = "$(PATH):$(HOME)/.local/bin";
      #   };
      #
      #   apps = [
      #
      #     {
      #       name = "Steam Deck";
      #       prep-cmd = [
      #         {
      #           do = "swaymsg 'output HEADLESS-1 mode 1280x800@60Hz pos 3840 0 scale 1 enable'";
      #           undo = "swaymsg 'output HEADLESS-1 disable'";
      #         }
      #       ];
      #       detached = [
      #         "setsid steam steam://open/bigpicture"
      #       ];
      #       image-path = "steam.png";
      #     }
      #
      #     {
      #       name = "Beyond TV";
      #       prep-cmd = [
      #         {
      #           do = "swaymsg 'output HEADLESS-1 mode 3840x2160@60Hz pos 3840 0 scale 1 enable'";
      #           undo = "swaymsg 'output HEADLESS-1 disable'";
      #         }
      #       ];
      #       detached = [
      #         "setsid steam steam://open/bigpicture"
      #       ];
      #       image-path = "steam.png";
      #     }
      #   ];
      # };
    };
  };
}
