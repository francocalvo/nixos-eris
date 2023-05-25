{ lib, config, pkgs, options, ... }:
with lib;
with lib.my;
let cfg = config.modules.shell.bash;
in {

  options.modules.shell.bash.enable = mkEnableOption "Set up bash shell";

  config = mkIf cfg.enable {
    options.home._ = {
      programs.bash = {
        enable = true;
        enableCompletion = true;
        enableVteIntegration = true;
        historyFileSize = 10000;
        historySize = 10000;
      };
    };
  };
}
