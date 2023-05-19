{ outputs, config, lib, ... }:
with lib;
let
  inherit (outputs) pkgs unstablePkgs user;
  cfg = config.modules.nixos.gaming;
in {
  imports = [ ./sunshine.nix ];

  options.modules.nixos.gaming = {
    enable = mkEnableOption "Enable gaming packages";
    sunshine = { enable = mkEnableOption "Enable sunshine"; };
  };

  config = mkIf cfg.enable {
    users.users.${user} = {
      packages = [
        # Launchers
        pkgs.steam
        pkgs.steamtinkerlaunch
        unstablePkgs.bottles

        # Benchmarking
        pkgs.glmark2
        pkgs.mangohud

        # Improve performance
        pkgs.gamemode
        pkgs.protonup-qt
        pkgs.protonup-ng
        pkgs.winetricks
        pkgs.gamescope
      ];
    };

    boot = {
      # Improve performance from https://wiki.archlinux.org/title/gaming
      kernel.sysctl."vm.max_map_count" = "2147483642";
      kernelParams = [ "tsc=reliable" "clocksource=tsc" ];
    };

    environment = {
      sessionVariables = rec {
        STEAM_EXTRA_COMPAT_TOOLS_PATHS =
          "\${HOME}/.steam/root/compatibilitytools.d";
        PATH = [ "\${XDG_BIN_HOME}" ];
      };
    };
  };
}
