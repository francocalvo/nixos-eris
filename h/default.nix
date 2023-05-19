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

{ lib, inputs, outputs, pkgs, home-manager, user, ... }:
with lib;
with lib.my;
let inherit (outputs) unstablePkgs serverName;
in {
  # Profile desktop
  desktop = lib.nixosSystem {
    # This allows me to pass the variables to the modules
    specialArgs = { inherit lib pkgs unstablePkgs inputs outputs user; };

    # Modules that are used
    modules = [
      {
        nixpkgs.pkgs = pkgs;
      }

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
          inherit pkgs unstablePkgs inputs user;
        };

        home-manager.users.${user} = {
          imports = [ (import ./desktop/home.nix) ];
        };
      }
    ];
  };

  # Adonis server
  adonis = lib.nixosSystem {
    specialArgs = { inherit inputs outputs; };
    modules = [
      ./configuration.nix
      ./adonis

      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit pkgs unstablePkgs inputs serverName;
        };

        home-manager.users.${serverName} = {
          imports = [ (import ./adonis/home.nix) ];
        };
      }

    ];
  };

}
