{ inputs, outputs, config, lib, ... }:
with lib;
let
  inherit (outputs) pkgs unstablePkgs user;
  cfg = config.modules.nixos.basicSoftware;
in {
  options.modules.nixos.basicSoftware = {
    enable = mkEnableOption "Enable software to make desktop more usable";
  };

  config = mkIf cfg.enable {

    users.users.${user} = {
      packages = with pkgs; [
        bitwarden
        brave
        calibre
        discord
        firefox
        libreoffice
        spotify
        qbittorrent
        vlc
        unrar
        unzip
        zip
        which
        git
        libsForQt5.kcalc
        latexrun
        texlive.combined.scheme-full
        teams
        thunderbird
      ];
    };

    # TODO: Autostart nextcloud-client
    home-manager.users.${user} = {
      services.nextcloud-client = {
        enable = true;
        startInBackground = true;
      };
    };

  };
}
