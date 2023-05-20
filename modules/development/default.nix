{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.dev;
in {
  options.modules.dev = {
    enable = mkEnableOption "Enable base packages for development";
  };

  config = mkIf cfg.enable {
    user = {
      packages = with pkgs; [ git zathura gcc dbeaver vscode llvm libcxx ];
    };

    home._ = {
      programs.direnv.enable = true;
      programs.direnv.nix-direnv.enable = true;
    };
  };
}
