{ config, lib, ... }:
with lib;
let cfg = config.modules.network.samba;
in {
  options.modules.network.samba = {
    enable = mkEnableOption "Enable samba";
  };

  config = mkIf cfg.enable {
    # Enable samba service
    services.samba = { enable = true; };
  };
}
