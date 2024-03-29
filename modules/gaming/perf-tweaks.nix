{ config, lib, ... }:
with lib;
let cfg = config.modules.gaming.performanceTweaks;
in {
  options.modules.gaming.performanceTweaks = {
    enable = mkEnableOption "Enable tweaks to improve performance";
  };

  config = mkIf cfg.enable {
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
