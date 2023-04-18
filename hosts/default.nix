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

{ lib, inputs, nixpkgs, home-manager, user, nix-gaming, ... }:
let
  system = "x86_64-linux";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true; # Propietary software
  };
  lib = nixpkgs.lib;
in {
  # Profile desktop
  desktop = lib.nixosSystem {
    inherit system;

    # This allows me to pass the variables to the modules
    specialArgs = { inherit inputs user nix-gaming; };

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
          inherit pkgs inputs user nix-gaming;
        };

        home-manager.users.${user} = {
          imports = [ (import ./desktop/home.nix) ];
        };
      }
    ];

  };
}
