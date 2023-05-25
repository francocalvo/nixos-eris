{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.gaming;
in {
  options.modules.gaming = {
    enable = mkEnableOption "Enable gaming packages";
  };

  # TODO: Add a way to add unstable packages
  config = mkIf cfg.enable {
    user = {
      packages = [
        # Launchers
        pkgs.steam
        pkgs.steamtinkerlaunch
        pkgs.bottles

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
  };
}
