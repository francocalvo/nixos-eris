{ config, lib, ... }:
with lib;
let cfg = config.modules.network.samba.olimpo;
in {
  options.modules.network.samba.olimpo = {
    connect = lib.mkEnableOption "Connect to Olimpo samba";
  };

  config = mkIf cfg.connect {
    warnings = [''
      You have enabled samba connection to Olimpo. For this to work you need
      to specify the credentials in /etc/samba/credentials."
    ''];

    # Implictly enable samba and open ports
    modules.network.samba = {
      enable = true;
      openFirewall = true;
    };

    # Mount Olimpo
    fileSystems."/mnt/olimpo" = {
      device = "//192.168.0.182/olimpus";
      fsType = "cifs";
      options = [
        "_netdev"
        "uid=1000"
        "gid=1000"
        "credentials=/etc/samba/credentials"
        "dir_mode=0770"
        "file_mode=0770"
        "vers=3.0"
      ];
    };
  };
}
