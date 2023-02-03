{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    vscodium
    teams
    thunderbird
    git
    cargo
    nodejs
    python3Full
    python310Packages.pip
    pipenv
    nodePackages_latest.npm
    yarn
    clang
    xclip # Allows me to access clipboard from Nvim
    ripgrep # Needed for Telescope in Nvim
    zathura

    openssl
    # openssl_1_1
  ];


  # nix-direnv
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
  programs.zsh.enable = true;
}
