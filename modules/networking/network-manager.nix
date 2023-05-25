{ config, lib, ... }:
with lib;
let cfg = config.modules.network.network-manager;
in {
  options.modules.network.network-manager = {
    enable = lib.mkEnableOption "Enable Network Manager";
  };

  config = mkIf cfg.enable {
    networking = {
      hostName = "${config.user.name}"; # Define your hostname.
      firewall = {
        enable = true;
        checkReversePath = false; # This is important for the VPN
      };
      networkmanager.enable = true;
    };
  };
}
