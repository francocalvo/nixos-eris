{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
    bitwarden
    brave
    calibre
    discord
    firefox
    mdds # libreoffice fails to build without it
    # libreoffice
    nextcloud-client
    spotify
    steam
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

  services = {
    nextcloud-client = {
      enable = true;
      startInBackground = true;
    };
  };
}
