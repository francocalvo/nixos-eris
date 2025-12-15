{ pkgs, config, lib, ... }:
with lib;
let cfg = config.modules.dev;
in {
  options.modules.dev = {
    enable = mkEnableOption "Enable base packages for development";
  };

  config = mkIf cfg.enable {
    user = {
      packages = with pkgs; [
        git
        remmina
        zathura
        kdePackages.okular
        gcc
        dbeaver-bin
        vscode
        libcxx
        insomnia
        bear
        pandoc
      ];
    };

    home._ = {
      programs.direnv.enable = true;
      programs.direnv.nix-direnv.enable = true;
      programs.direnv.enableZshIntegration = true;
    };
  };
}
