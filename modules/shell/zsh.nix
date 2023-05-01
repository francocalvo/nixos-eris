{ outputs, config, ... }:
let
  inherit (outputs) pkgs user;
  inherit (pkgs) lib;
  cfg = config.modules.internal.shell.zsh;
in {
  options.modules.internal.shell.zsh = lib.mkEnableOption "Set up zsh shell";

  config = lib.mkIf cfg {
    home-manager.users.${user} = {
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
