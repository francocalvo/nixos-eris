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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager }:
    let user = "calvo";
    in {
      nixosConfigurations = (import ./hosts {
        inherit inputs nixpkgs home-manager user;
        inherit (nixpkgs) lib;
      });
    };
}
