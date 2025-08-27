{ pkgs, config, lib, ... }:
with lib;
with lib.my;
let cfg = config.modules.dev.scheme;
in {
  options.modules.dev.scheme = {
    enable = mkEnableOption "Enable MIT Scheme packages";
  };

  config = mkIf cfg.enable {
    modules.dev.enable = true;

    user = { packages = with pkgs; [ mitscheme ]; };
  };
}
