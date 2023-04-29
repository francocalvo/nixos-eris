# So far there is just one profile for my desktop. More to come?
# Maybe when Asahi becomes more reliable.
#
# The current referenced files are:
#
#  flake.nix 
#   └─ ./hosts  
#       ├─ default.nix *
#       ├─ configuration.nix 
#       └─ ./desktop
#            ├─ ./default.nix
#            ├─ ./home.nix 
#            └─ ./hardware-configuration.nix 

{ lib, inputs, outputs, nixpkgs, stable, unstable, home-manager, user
, nix-gaming, ... }:
let
  inherit (outputs) pkgs unstablePkgs;
  mods = builtins.attrValues outputs.nixosModules;
  lib = nixpkgs.lib;
in {

  # Adonis server
  adonis = lib.nixosSystem {
    specialArgs = { inherit inputs outputs; };
    modules = [ ./configuration.nix ./adonis ] ++ mods;
  };

  # Profile desktop
  desktop = lib.nixosSystem {

    # This allows me to pass the variables to the modules
    specialArgs = { inherit pkgs unstablePkgs inputs outputs user nix-gaming; };

    # Modules that are used
    modules = [
      # General configuration
      ./configuration.nix

      # Main NixOS configuration
      ./desktop

      # Home Manager configuration
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit pkgs unstablePkgs inputs user nix-gaming;
        };

        home-manager.users.${user} = {
          imports = [ (import ./desktop/home.nix) ];
        };
      }
    ] ++ mods;
  };
}
