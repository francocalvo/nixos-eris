{ config, pkgs, lib, ... }: {
  # Unfree Software
  nixpkgs.config.allowUnfree = true;

  # Keep the system updated
  system.autoUpgrade = {
    enable = true;
    channel = "https://nixos.org/channels/nixos-unstable";
  };

  # Keep the system clean
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}
