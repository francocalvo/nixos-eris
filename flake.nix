# francocalvo - dev@francocalvo.ar
# This is my Nix flake that build my current NixOS setup.
# Most information can be found in the 3h tutorial on Nix and NixOS by Matthias
# Benaets.
# 
# Referenced files:
#  flake.nix *             
#   └─ ./hosts
#      └─ default.nix

{
  description = "A poor attempt at a reproducible environment";

  inputs = {
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, unstable, home-manager, ... }:
    let
      inherit (self) outputs;

      inherit (lib.my) mapModules mapModulesRec mapHosts;

      lib = nixpkgs.lib.extend (self: super: {
        my = import ./lib {
          inherit pkgs inputs;
          lib = self;
        };
      });

      user = "calvo";
      serverName = "adonis";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true; # Propietary software
      };
      unstablePkgs = import unstable { inherit system; };

    in {
      lib = lib.my;

      nixosModules = mapModulesRec ./modules import;

      nixosConfigurations = mapHosts ./hosts { };
    };
}
