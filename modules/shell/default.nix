{ outputs, inputs, config, ... }:
let
  inherit (outputs) pkgs user;
  inherit (pkgs) lib;
  inherit (lib) types;
  cfg = config.modules.nixos.shell;
in {
  options.modules.nixos.shell = lib.mkOption {
    type = types.enum [ "zsh" "bash" ];
    default = "bash";
    example = "zsh";
    description = lib.mdDoc "Which shell to use";
  };

  config = lib.mkMerge [
    ################### zsh ###################
    (lib.mkIf (cfg == "zsh") {
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
    })

    ################### bash ###################
    (lib.mkIf (cfg == "bash") {
      home-manager.users.${user} = {
        programs.bash = {
          enable = true;
          enableCompletion = true;
          enableVteIntegration = true;
          historyFileSize = 10000;
          historySize = 10000;
        };
      };
    })
  ];
}
