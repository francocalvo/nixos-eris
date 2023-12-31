{ inputs, pkgs, config, lib, ... }:
with lib;
with lib.my;
let cfg = config.modules.dev.python;
in {
  options.modules.dev.nodejs = {
    enable = mkEnableOption "Enable nodejs packages";
  };

  config = mkIf cfg.enable {
    # Implicitly enable dev base
    modules.dev.enable = true;

    user = { packages = with pkgs; [ nodejs nodePackages_latest.npm yarn ]; };
  };
}
