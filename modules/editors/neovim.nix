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
          nodePackages_latest.vscode-json-languageserver-bin
          nodePackages_latest.yaml-language-server
          nodePackages_latest.vscode-langservers-extracted
          nodePackages_latest.markdownlint-cli
          nodePackages_latest.typescript-language-server

          llvmPackages_15.clang-unwrapped

          vscode-extensions.prisma.prisma

          nil
          mypy
          beancount-language-server
          marksman
          lua-language-server
          stylua
          deadnix
          nixfmt
          rustc
          pyright
          black
          pylint
          sqls
          sqlfluff
          rust-analyzer
          terraform-ls
          trivy
          ruff
          ruff-lsp
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
