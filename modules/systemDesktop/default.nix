{ config, pkgs, lib, ... }: {

  imports = [
    ./services.nix
    ./networking.nix
    ./video.nix
    ./bootloader.nix
    ./meta.nix
    ./sound.nix
  ];

  ######## OTHER SETTINGS
  # Select internationalisation properties.
  i18n.defaultLocale = "es_AR.UTF-8";

  # Set your time zone.
  time.timeZone = "America/Argentina/Cordoba";

  # This allows to use MTP with Kindle, Android, etc.
  services = { gvfs.enable = true; };

}
