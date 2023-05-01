{ inputs, outputs, config, lib, ... }:
with lib;
let
  inherit (outputs) pkgs unstablePkgs user;
  cfg = config.modules.nixos.basics;
in {
  options.modules.nixos.basics = {
    enable = mkEnableOption "Enable base packages";
  };

  config = mkIf cfg.enable {

    users.users.${user} = {
      packages = with pkgs; [
        bitwarden
        brave
        calibre
        discord
        firefox
        mdds # libreoffice fails to build without it
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
