{ config, pkgs, unstablePkgs, inputs, user, ... }:

{
  users.users.${user} = {
    packages = [
      pkgs.steam
      pkgs.protonup-ng
      pkgs.lutris
      pkgs.gamemode
      inputs.nix-gaming.packages.${pkgs.hostPlatform.system}.wine-ge # installs a package
      pkgs.winetricks
      unstablePkgs.bottles
    ];
  };

  environment = {
    sessionVariables = rec {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "\${HOME}/.steam/root/compatibilitytools.d";
      PATH = [ "\${XDG_BIN_HOME}" ];
    };
  };
}
