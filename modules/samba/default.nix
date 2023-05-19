{ config, lib, ... }:
with lib;
let cfg = config.modules.nixos.samba;
in {
  options.modules.nixos.samba = {
    olimpo.connect = lib.mkEnableOption "Connect to Olimpo samba";
    openFirewall = lib.mkEnableOption "Open firewall for samba";
  };

  config = mkIf cfg.olimpo.connect (mkMerge [
    {
      warnings = [''
        You have enabled samba connection to Olimpo. For this to work you need
        to specify the credentials in /etc/samba/credentials."
      ''];

      services.samba = { enable = true; };
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
    }

    (lib.mkIf cfg.openFirewall { services.samba.openFirewall = true; })
  ]);
}
