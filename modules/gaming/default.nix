{ inputs, outputs, config, lib, ... }:
with lib;
let
  inherit (outputs) pkgs unstablePkgs user;
  cfg = config.modules.nixos.gaming;
in {
  options.modules.nixos.gaming = {
    enable = mkEnableOption "Enable gaming packages";
    sunshine = {
      enable = mkEnableOption "Enable sunshine";
      disableFirewall = mkEnableOption "Disable firewall";
      enableAvahi = mkEnableOption "Enable avahi";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      users.users.${user} = {
        packages = [
          # Launchers
          pkgs.steam
          unstablePkgs.bottles

          # Benchmarking
          pkgs.glmark2
          pkgs.mangohud

          # Improve performance
          pkgs.gamemode
          pkgs.protonup-qt
          pkgs.protonup-ng
          pkgs.winetricks
          pkgs.gamescope
        ];
      };

      boot = {
        # Improve performance from https://wiki.archlinux.org/title/gaming
        kernel.sysctl."vm.max_map_count" = "2147483642";
        kernelParams = [ "tsc=reliable" "clocksource=tsc" ];
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
    (mkIf cfg.sunshine.enable {
      boot = { kernelModules = [ "uinput" ]; };
      services = {
        udev.extraRules = ''
          KERNEL=="uinput", GROUP="input", MODE="0660" OPTIONS+="static_node=uinput"
        '';
      };

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

    ######################### AVAHI ############################
    (mkIf cfg.sunshine.enableAvahi {
      services.avahi = {
        enable = true;
        reflector = true;
        nssmdns = true;
        publish = {
          enable = true;
          addresses = true;
          userServices = true;
          workstation = true;
        };
      };
    })

    ######################### FIREWALL ############################
    (mkIf cfg.sunshine.disableFirewall {
      networking.firewall = { enable = false; };
    })
  ]);
}
