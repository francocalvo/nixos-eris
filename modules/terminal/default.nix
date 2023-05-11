{ outputs, inputs, config, ... }:
let
  inherit (outputs) pkgs user;
  inherit (pkgs) lib;
  inherit (lib) types;
  cfg = config.modules.nixos.terminal;
in {
  options.modules.nixos.terminal = lib.mkOption {
    type = types.enum [ "alacritty" ];
    default = "alacritty";
    example = "alacritty";
    description = lib.mdDoc "Which terminal emulator to use";
  };

  config = lib.mkMerge [
    ################### alacritty ###################
    (lib.mkIf (cfg == "alacritty") {
      home-manager.users.${user} = {
        programs.alacritty = {
          enable = true;
          settings = {
            font = { normal = { family = "MesloLGS NF"; }; };
          }; # Used for P10K
        };
      };
    })
  ];
}