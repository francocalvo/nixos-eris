{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    bitwarden
    brave
    calibre
    discord
    firefox
    nextcloud-client
    vscodium
    spotify
    steam
    teams
    tree
    thunderbird
    qbittorrent
    vlc
    unrar
    unzip
    zip
    which
    git
  ];

  services = {
    nextcloud-client = {
      enable = true;
      startInBackground = true;
    };
  };
}
