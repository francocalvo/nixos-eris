{ inputs, outputs, config, lib, ... }:
with lib;
let
  inherit (outputs) pkgs unstablePkgs user;
  cfg = config.modules.nixos.dev;
in {
  options.modules.nixos.dev = {
    enable = mkEnableOption "Enable base packages";
    python = mkEnableOption "Enable python packages";
    nodejs = mkEnableOption "Enable nodejs packages";
  };

  config = mkMerge [
    { }
    ############# BASE
    (mkIf cfg.enable {
      users.users.${user} = {
        packages = with pkgs; [ git zathura gcc dbeaver vscode llvm libcxx ];
      };

      home-manager.users.${user} = {
        programs.direnv.enable = true;
        programs.direnv.nix-direnv.enable = true;
      };
    })
    ############# PYTHON
    (mkIf cfg.python {
      users.users.${user} = {
        packages = with pkgs; [
          python3Full
          python310Packages.pip
          pipenv
          python310Packages.flake8
          python310Packages.pandas
        ];
      };
    })
    ############# NODEJS
    (mkIf cfg.nodejs {
      users.users.${user} = {
        packages = with pkgs; [ nodejs nodePackages_latest.npm yarn ];
      };
    })
  ];
}
