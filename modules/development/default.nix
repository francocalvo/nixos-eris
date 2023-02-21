{ config, pkgs, ... }:

{
  imports = [ ./nodejs.nix ./python.nix ];

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
