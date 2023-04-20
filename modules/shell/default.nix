{ config, lib, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = { normal = { family = "MesloLGS NF"; }; };
    }; # Used for P10K
  };

  programs.zsh = {
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
}
