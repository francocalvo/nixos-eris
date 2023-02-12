{ config, pkgs, lib, ... }: {

  imports = [
    ./bootloader.nix
    ./docker.nix
    ./meta.nix
    ./networking.nix
    ./video.nix
    ./sound.nix
  ];

  ######## OTHER SETTINGS
  # Select internationalisation properties.
  i18n.defaultLocale = "es_AR.UTF-8";

  # Set your time zone.
  time.timeZone = "America/Argentina/Cordoba";

  # This allows to use MTP with Kindle, Android, etc.
  services = { gvfs.enable = true; };

  # This allows the global install of a keyring
  services.gnome.gnome-keyring.enable = true;
}
