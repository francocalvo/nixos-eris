{ lib, config, pkgs, options, ... }:
with lib;
with lib.my;
let cfg = config.modules.shell.zsh;
in {
  options.modules.shell.zsh = mkEnableOption "Set up zsh shell";

  config = mkIf cfg {
    options.home._ = {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
        enableSyntaxHighlighting = true;

        history = {
          expireDuplicatesFirst = true;
          ignorePatterns = [ "ls" "ls *" "tree" "git init" ];
          size = 10000;
        };

        oh-my-zsh = { enable = true; };

        plugins = [
          {
            file = "/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
            name = "powerlevel10k";
            src = pkgs.zsh-powerlevel10k;
          }
          {
            file = "p10k.zsh";
            name = "powerlevel10k-config";
            src = lib.cleanSource ../../dotfiles/zsh;
          }
        ];
      };
    };
  };
}
