{ inputs, outputs, config, lib, ... }:
with lib;
let
  inherit (outputs) pkgs unstablePkgs user;
  cfg = config.modules.nixos.gaming;
in {
  options.modules.nixos.gaming = {
    enable = mkEnableOption "Enable gaming packages";
    sunshine = mkEnableOption "Enable sunshine";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      users.users.${user} = {
        packages = [
          pkgs.steam
          pkgs.protonup-ng
          pkgs.lutris
          pkgs.gamemode
          inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.wine-ge # installs a package
          pkgs.winetricks
          unstablePkgs.bottles
        ];
      };

      environment = {
        sessionVariables = rec {
          STEAM_EXTRA_COMPAT_TOOLS_PATHS =
            "\${HOME}/.steam/root/compatibilitytools.d";
          PATH = [ "\${XDG_BIN_HOME}" ];
        };
      };
    }
    (mkIf cfg.sunshine {
      security.wrappers.sunshine = {
        owner = "root";
        group = "root";
        capabilities = "cap_sys_admin+p";
        source = "${pkgs.sunshine}/bin/sunshine";
      };

      systemd.user.services.sunshine = {
        description = "sunshine";
        wantedBy = [ "graphical-session.target" ];
        serviceConfig = {
          ExecStart = "${config.security.wrapperDir}/sunshine";
        };
      };

    })
  ]);
}
