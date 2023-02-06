{ config, pkgs, lib, ... }: {
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    liveRestore = false;
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [ "--all" ];
    };
  };
}
