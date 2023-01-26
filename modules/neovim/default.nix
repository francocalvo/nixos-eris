{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  # Most packages are used by cargo or null-ls

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [
      deadnix
      nixfmt
      rustc
      nodePackages_latest.prettier
      stylua
    ];

  };

  home.file.".config/nvim" = {
    source = ../../dotfiles/nvim;
    recursive = true;
  };

}
