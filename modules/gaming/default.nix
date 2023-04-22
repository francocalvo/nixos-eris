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
          pkgs.protonup-ng
          pkgs.lutris
          pkgs.gamemode
          inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.wine-ge # installs a package
          pkgs.winetricks
          unstablePkgs.bottles
        ];
      };

      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      };

      environment = {
        sessionVariables = rec {
          STEAM_EXTRA_COMPAT_TOOLS_PATHS =
            "\${HOME}/.steam/root/compatibilitytools.d";
          PATH = [ "\${XDG_BIN_HOME}" ];
        };
      };
    }
    ######################### SUNSHINE ############################
    (mkIf cfg.sunshine {
      boot.kernelModules = [ "uinput" ];
      services = {
        avahi = {
          enable = true;
          publish = { enable = true; };
        };

        udev.extraRules = ''
          KERNEL=="uinput", GROUP="input", MODE="0660" OPTIONS+="static_node=uinput"
        '';
      };

      environment.systemPackages = [ pkgs.sunshine ];
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
