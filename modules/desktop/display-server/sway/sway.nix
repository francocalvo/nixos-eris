{ lib, pkgs, config, ... }:
with lib;
with lib.my;
let cfg = config.modules.d.displayServer.sway;
in {
  options.modules.d.displayServer.sway.enable =
    lib.mkEnableOption "Wayland display server";

  config = lib.mkIf cfg.enable {
    security.polkit.enable = true;

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      # gtk portal needed to make gtk apps happy
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    programs.sway = {
      enable = true;
      extraSessionCommands = ''
        export SDL_VIDEODRIVER=wayland
        export _JAVA_AWT_WM_NONREPARENTING=1
        export QT_QPA_PLATFORM=wayland
        export XDG_CURRENT_DESKTOP=sway
        export XDG_SESSION_DESKTOP=sway
      '';
    };

    home._ = {
      home.packages = with pkgs; [
        swaybg
        autotiling
        glib
        wl-clipboard
        wofi
        xwayland
        xdg-desktop-portal
        xdg-desktop-portal-wlr
        grim
      ];

      xdg.configFile = {
        "wofi/config".text = "allow_images=true";
        "wofi/style.css".source = ./wofi.css;
      };

      programs = { wofi = enable; };

      home.file.".config/sway" = {
        source = builtins.toPath "${config.paths.dotsDir}/sway";
        recursive = true;
      };

      programs.waybar = {
        enable = true;
        style = builtins.readFile ./waybar.css;
        systemd = {
          enable = true;
          target = "sway-session.target";
        };
        settings = [{
          layer = "top";
          position = "bottom";
          height = 20;
          output = [ "eDP-1" ];
          modules-left = [ "sway/workspaces" "sway/mode" ];
          modules-center = [ "clock" ];
          modules-right = [
            "custom/rebuild"
            "network#1"
            "network#2"
            "cpu"
            "backlight"
            "pulseaudio"
            "battery"
            "idle_inhibitor"
          ];
          "custom/rebuild" = {
            format = "rebuild: {}";
            max-length = 25;
            interval = 2;
            exec-if = "test -f /tmp/nixos-rebuild.status";
            exec = ''echo "$(< /tmp/nixos-rebuild.status)"'';
            # Waybar env does not include my normal PATH so I'm using fish as a wrapper
            on-click = "${pkgs.fish}/bin/fish -c view-rebuild-log";
          };
          "sway/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            format = "{icon}";
            format-icons = {
              "1" = "term";
              "2" = "www";
              "3" = "notes";
              "4" = "sys";
              "5" = "vibes";
            };
            persistent_workspaces = {
              "1" = [ ];
              "2" = [ ];
              "3" = [ ];
              "4" = [ ];
              "5" = [ ];
            };
          };
          cpu = {
            interval = 10;
            format = "{usage} ";
          };
          memory = {
            interval = 30;
            format = "{} ";
          };
          disk = {
            interval = 30;
            format = "{percentage_used} ";
          };
          "network#1" = {
            max-length = 60;
            interface = "wl*";
            # format = "{ifname}";
            # format-ethernet = "{ifname} ";
            format-disconnected = "";
            format-wifi = "{essid} {signalStrength} ";
            on-click = "${pkgs.wezterm}/bin/wezterm start nmtui";
          };
          "network#2" = {
            max-length = 60;
            interface = "proton*";
            format = "";
            format-disconnected = "";
            on-click = "${pkgs.wezterm}/bin/wezterm start nmtui";
          };
          pulseaudio = {
            format = "{volume} {icon}";
            format-bluetooth = "{volume} {icon} ";
            format-muted = "{volume} ";
            format-icons = { default = [ "" "" ]; };
            on-click = "pavucontrol";
          };
          clock = {
            format = "{:%a %b %d %I:%M %p} 󱛡";
            format-alt = "{:week %U day %j} 󱛡";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
          };
          battery = {
            format = "{capacity} {icon}";
            format-icons = [ " " " " " " " " " " ];
            max-length = 40;
          };
          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = " ";
              deactivated = " ";
            };
          };
          backlight = {
            interval = 5;
            format = "{percent} {icon}";
            format-icons = [ "" "" "" ];
          };
        }];
      };

    };
  };
}
