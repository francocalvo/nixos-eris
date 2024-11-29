{ config, lib, pkgs, ... }:
with lib;
with lib.my;
let cfg = config.modules.editors.neovim;
in {
  options.modules.editors.neovim = { enable = mkEnableOption "Enable neovim"; };

  config = mkIf cfg.enable {

    environment.shellAliases = {
      wik = ''
        vim ~/Nextcloud/Wiki/Personal/main.md
      '';
    };

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
          wl-clipboard # System clipboard
          ripgrep # Telescope

          # Formatters and LSP
          nodePackages.prettier
          nodePackages_latest.eslint
          nodePackages_latest.yaml-language-server
          nodePackages_latest.vscode-langservers-extracted
          nodePackages_latest.markdownlint-cli

          llvmPackages_15.clang-unwrapped

          vscode-extensions.prisma.prisma

          beancount-language-server
          nil
          mypy
          marksman
          lua-language-server
          stylua
          luajitPackages.luacheck
          deadnix
          nixfmt-classic
          rustc
          pyright
          black
          pylint
          sqls
          sqlfluff
          pgformatter
          rust-analyzer
          terraform-ls
          trivy
          ruff
          ruff-lsp
          gopls
        ];
      };

      # home.file.".config/nvim" = {
      #   source =
      #     lib.cleanSource (builtins.toPath "${config.paths.dotsDir}/nvim");
      #   recursive = true;
      # };
    };
  };
}
