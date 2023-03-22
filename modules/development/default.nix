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
    microsoft-edge # Bing Chat
  ];

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.zsh.enable = true;
}
