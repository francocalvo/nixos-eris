{ config, lib, ... }:
with lib;
let cfg = config.modules.network.samba;
in {
  options.modules.network.samba = {
    openFirewall = lib.mkEnableOption "Open firewall for samba";
  };

  config = mkIf cfg.openFirewall { services.samba.openFirewall = true; };
}
