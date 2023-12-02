{ inputs, pkgs, config, lib, ... }:
with lib;
with lib.my;
let cfg = config.modules.dev.docker;
in {
  options.modules.dev.distrobox = {
    enable = mkEnableOption "Enable wrapper to create and start containers";
  };

  config = mkIf cfg.enable {
    # Implicitly enable dev base
    modules.dev.enable = true;

    user = { packages = with pkgs; [ distrobox ]; };
  };
}
