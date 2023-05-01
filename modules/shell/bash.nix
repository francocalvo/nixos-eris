{ outputs, config, ... }:
let
  inherit (outputs) pkgs user;
  inherit (pkgs) lib;
  cfg = config.modules.internal.shell.bash;
in {
  options.modules.internal.shell.bash = lib.mkEnableOption "Set up bash shell";

  config = lib.mkIf cfg {
    home-manager.users.${user} = {
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
