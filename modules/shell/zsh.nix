{ lib, config, pkgs, options, ... }:
with lib;
with lib.my;
let cfg = config.modules.shell.zsh;
in {
  options.modules.shell.zsh.enable = mkEnableOption "Set up zsh shell";

  config = mkIf cfg.enable {
    programs.zsh.enable = true;

    user = {
      shell = pkgs.zsh;
      packages = with pkgs; [ atuin zsh-powerlevel10k ];
    };

    home._ = {
      home.file."${config.user.home}/.oh-my-zsh/custom/themes/powerlevel10k" = {
        source = lib.cleanSource (builtins.fetchGit {
          url = "https://github.com/romkatv/powerlevel10k";
          rev = "da9b03777c4f2390c7e3f5c720ee4689336f811b";
        });
        recursive = true;
      };

      programs.atuin = {
        enable = true;
        enableZshIntegration = true;
        flags = [ "--disable-up-arrow" ];
        settings = {
          auto_sync = true;
          sync_frequency = "5m";
          sync_address = "https://api.atuin.sh";
          search_mode = "fuzzy";
          search_mode_shell_up_key_binding = "prefix";
        };
      };

      programs.zsh = {
        enable = true;
        envExtra = ''source "$HOME/.p10k.zsh"'';
        enableCompletion = true;
        syntaxHighlighting.enable = true;

        history = {
          expireDuplicatesFirst = true;
          ignorePatterns = [ "ls" "ls *" "tree" "git init" ];
          size = 10000;
        };

        oh-my-zsh = {
          enable = true;
          # theme = "powerlevel10k/powerlevel10k";
        };

        # promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

        # # TODO: fix how the powerlevel10k-config is used
        plugins = [{
          file = "/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
        }
        # {
        #   file = "p10k.zsh";
        #   name = "powerlevel10k-config";
        #   src = builtins.toPath "${config.paths.dotsDir}/zsh";
        # }
          ];
      };
    };
  };
}
