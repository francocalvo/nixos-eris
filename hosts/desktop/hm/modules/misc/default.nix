{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [ deadnix nixfmt clang rustc wget cargo ];

}
