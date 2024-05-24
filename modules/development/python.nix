{ pkgs, config, lib, ... }:
with lib;
with lib.my;
let cfg = config.modules.dev.python;
in {
  options.modules.dev.python = {
    enable = mkEnableOption "Enable python packages";
  };

  config = mkIf cfg.enable {
    modules.dev.enable = true;

    user = {
      packages = with pkgs; [ python312 python312Packages.pip ];
    };
  };
}
