{ config, pkgs, ... }:

{
  imports = [ ./nodejs.nix ];

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    teams
    thunderbird
    git
    cargo
    python3Full
    python310Packages.pip
    pipenv
    clang
    xclip # Allows me to access clipboard from Nvim
    ripgrep # Needed for Telescope in Nvim
    zathura
    openssl
    dbeaver
    # openssl_1_1
  ];
}
