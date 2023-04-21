{ inputs, outputs, config, lib, ... }:
with lib;
let
  inherit (outputs) pkgs unstablePkgs user;
  cfg = config.modules.nixos.neovim;
in {
  options.modules.nixos.neovim = { enable = mkEnableOption "Enable neovim"; };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
    };

    home-manager.users.${user} = {
      home.file.".config/nvim" = {
        source = ../../dotfiles/nvim;
        recursive = true;
      };

      # TODO: Improve?
      programs.neovim = {
        extraPackages = with pkgs; [
          vimPlugins.packer-nvim
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
    };

  };
}
