{ config, inputs, lib, pkgs, ... }:

with lib; {
  imports = [ inputs.home-manager.nixosModules.home-manager ]
    ++ my.mapModulesRec' ./modules import;

  # Keep the system clean
  nix = {
    settings.auto-optimise-store = true;
    package = pkgs.nixVersions.unstable;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  # Keep the system updated
  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
  };

  # Use the GRUB 2 boot loader.
  boot = {
    kernelPackages = mkDefault pkgs.linuxPackages_latest;
    loader.grub = {
      enable = true;
      efiInstallAsRemovable = true;
      efiSupport = true;
      devices = [ "nodev" ];
      useOSProber = true;
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "es_AR.UTF-8";

  # Set your time zone.
  time.timeZone = "America/Argentina/Cordoba";
  services.ntp.enable = true;

  programs.git = {
    enable = true;
    config = {
      user.name = "francocalvo";
      user.email = "dev@francocalvo.ar";
    };
  };

  # Base packages
  environment.systemPackages = with pkgs; [
    cached-nix-shell
    curl
    vim
    neovim
    wget
    unzip
  ];

  systemd.services = {
    tune-usb-autosuspend = {
      description = "Disable USB autosuspend";
      wantedBy = [ "multi-user.target" ];
      serviceConfig = { Type = "oneshot"; };
      unitConfig.RequiresMountsFor = "/sys";
      script = ''
        echo -1 > /sys/module/usbcore/parameters/autosuspend
      '';
    };
  };
}
