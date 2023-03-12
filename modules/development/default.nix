{ config, pkgs, ... }:

{
  imports = [ ./nodejs.nix ./python.nix ];

  programs.alacritty = {
    enable = true;
    settings = {
      font = { normal = { family = "MesloLGS NF"; }; };
    }; # Used for P10K
  };


  home.packages = with pkgs; [
    git
    zathura
    gcc
    dbeaver
    vscode
    llvm
    libcxx
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.zsh.enable = true;
}
