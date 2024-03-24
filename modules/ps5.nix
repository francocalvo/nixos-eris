{ pkgs, lib, config, ... }:
with lib;
with lib.my;
let cfg = config.modules.ps5;
in {
  options.modules.ps5 = {
    enable = mkEnableOption "Enable NFS share for PS5 pkgs";
  };

  config = mkIf cfg.enable {

    services.nfs.server = {
      enable = true;
      hostName = "192.168.1.202";
      exports = "/orfeo/PS5 192.168.1.0/24(rw,async,no_root_squash)";
      lockdPort = 4001;
      mountdPort = 4002;
      statdPort = 4000;
      extraNfsdConfig = "";
    };

    networking.firewall = {
      enable = true;
      # for NFSv3; view with `rpcinfo -p`
      allowedTCPPorts = [ 111 2049 4000 4001 4002 20048 ];
      allowedUDPPorts = [ 111 2049 4000 4001 4002 20048 ];
    };

  };
}
