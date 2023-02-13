{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    extraPackages = with pkgs; [
      cargo # Used for packer
      deadnix
      nixfmt
      rustc
      nodePackages_latest.prettier
      stylua
      nil
      xclip # Allows me to access clipboard from Nvim
      ripgrep # Needed for Telescope in Nvim
    ];
  };

  home.file.".config/nvim" = {
    source = ../../dotfiles/nvim;
    recursive = true;
  };
}
