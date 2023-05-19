{ outputs, ... }:
let inherit (outputs) pkgs serverName;
in {
  imports = [ ./hardware-configuration.nix ];
  nixpkgs.config.allowUnfree = true;
  networking.firewall.enable = false;
  programs.zsh.enable = true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

  # Modules
  modules.nixos = { samba.olimpo.connect = true; };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${serverName} = {
    isNormalUser = true;
    extraGroups =
      [ "wheel" "root" "networkmanager" "audio" "video" "docker" "input" ];
    shell = pkgs.zsh;
  };

  # Enable the X11 windowing system.
  services = { openssh.enable = true; };
  system.stateVersion = "22.11";
}
