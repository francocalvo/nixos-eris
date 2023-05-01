{ outputs, config, ... }:
let
  inherit (outputs) pkgs;
  inherit (pkgs) lib;
  inherit (lib) types;
  inherit config;
  cfg = config.modules;
in {
  imports = [ ./bash.nix ./zsh.nix ];

  options.modules.nixos.shell = lib.mkOption {
    type = types.enum [ "zsh" "bash" ];
    default = "bash";
    example = "zsh";
    description = lib.mdDoc "Which shell to use";
  };

  config = lib.mkMerge [
    ################### common ###################
    { }
    ################### specific ###################
    (lib.mkIf (cfg.nixos.shell != null) {
      modules.internal.shell.${cfg.nixos.shell} = true;
    })
  ];
}
