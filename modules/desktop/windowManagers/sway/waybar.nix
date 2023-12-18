{ lib, pkgs, config, ... }:
with lib;
with lib.my;
let
  cfg = config.modules.d.windowManager.sway.waybar;
  audioSupport = config.modules.hardware.sound.enable;
in {
  options.modules.d.windowManager.sway.waybar.enable =
    lib.mkEnableOption "Bar for Wayland";

  config = mkIf cfg.enable {
    # Some extra scripts for easier media support
    user.packages = with pkgs; mkIf audioSupport [ pavucontrol playerctl ];

    home._ = {
      home.packages = with pkgs; [ htop blueberry ];

      programs.waybar = {
        enable = true;
        package = pkgs.waybar.override { pulseSupport = audioSupport; };
      };

      # Waybar config
      home.file.".config/waybar" = {
        source = builtins.toPath "${config.paths.dotsDir}/waybar";
        recursive = true;
      };

      services.dunst = {
        iconTheme = {
          name = "Nordzy-green";
          package = pkgs.nordzy-icon-theme;

        };

        settings = {
          global = {
            monitor = 0;
            follow = "mouse";
            offset = "0x5";
            indicate_hidden = true;
            shrink = false;
            transparency = 1;
            notification_height = 0;
            separator_height = 2;
            padding = 0;
            horizontal_padding = 8;
            frame_width = 0;
            frame_color = "#5e81ac";
            separator_color = "frame";
            font = "FiraCode Nerd Font:style=Regular";
            line_height = 1;
            markup = true;
            format = ''
              <b>%s %p</b>
              %b
              %p'';
            alignment = "left";
            show_age_threshold = 30;
            world_wrap = true;
            icon_position = "left";
            max_icon_size = 32;
            browser = "firefox";
          };

          urgency_low = {
            msg_urgency_low = "low";
            background = "#2E344090";
            foreground = "#D8DEE9";
            timeout = 4;
          };

          urgency_normal = {
            msg_urgency_normal = "normal";
            background = "#3B425299";
            foreground = "#E5E9F0";
            timeout = 4;
          };

          urgency_critical = {
            msg_urgency_critical = "critical";
            background = "#2E344099";
            foreground = "#D08770";
            timeout = 4;
          };
        };
      };

      services.dunst.enable = true;

    };
  };
}
