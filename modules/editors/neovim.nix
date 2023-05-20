{ config, lib, pkgs, ... }:
with lib;
with lib.my;
let cfg = config.modules.editors.neovim;
in {
  options.modules.editors.neovim = { enable = mkEnableOption "Enable neovim"; };

  config = mkIf cfg.enable {
    home._ = {
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        withNodeJs = true;
        withPython3 = true;
        extraPackages = with pkgs; [
          vimPlugins.packer-nvim # Packer
          cargo # Packer
          xclip # System clipboard
          ripgrep # Telescope

          # Formatters and LSP
          nodePackages_latest.prettier
          stylua
          nil
          deadnix
          nixfmt
          rustc
          black
          pylint
        ];
      };

      home.file.".config/nvim" = {
        source =
          lib.cleanSource (builtins.toPath "${config.paths.dotsDir}/nvim");
        recursive = true;
      };
    };
  };
}
