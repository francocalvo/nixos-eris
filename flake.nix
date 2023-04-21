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
    stable.url = "github:nixos/nixpkgs/nixos-21.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-gaming.url = "github:fufexan/nix-gaming";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, stable, nixpkgs, unstable, home-manager, nix-gaming, ... }:
    let
      user = "calvo";
      inherit (self) outputs;
    in rec {
      nixosModules = import ./modules;
      nixosConfigurations = (import ./hosts {
        inherit inputs outputs nixpkgs stable unstable home-manager user
          nix-gaming;
        inherit (nixpkgs) lib;
      });
    };
}
