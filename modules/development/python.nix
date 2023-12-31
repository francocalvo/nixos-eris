{ pkgs, config, lib, ... }:
with lib;
with lib.my;
let cfg = config.modules.dev.nodejs;
in {
  options.modules.dev.python = {
    enable = mkEnableOption "Enable python packages";
  };

  config = mkIf cfg.enable {
    # Implicitly enable dev base
    modules.dev.enable = true;

    user = {
      packages = with pkgs; [ python3Full python310Packages.pip pipenv poetry ];
    };
  };
}
