{ inputs, pkgs, config, lib, ... }:
with lib;
with lib.my;
let cfg = config.modules.dev.docker;
in {
  options.modules.dev.docker = {
    enable = mkEnableOption "Enable python packages";
  };

  config = mkIf cfg.enable {
    # Implicitly enable dev base
    modules.dev.enable = true;

    user = { packages = with pkgs; [ docker ]; };
    virtualisation.docker.enable = true;
    user.extraGroups = [ "docker" ];
  };
}
