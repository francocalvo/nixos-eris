# NixOS Configuration for my desktop. This is mainly global confugrations,
# since most programs and per user configs are managed by home-manager.
#
# The current referenced files are:
#
#  flake.nix 
#   ├─ ./hosts  
#   │   ├─ default.nix 
#   │   └─ ./desktop
#   │       └─ ./home.nix *
#   └  ./modules
#       ├─ i3 
#       ├─ development 
#       ├─ fonts
#       ├─ programs
#       ├─ neovim
#       └─ shell

{ serverName, ... }: {

  # Paths managed by Home Manager
  home.username = serverName;
  home.homeDirectory = "/home/${serverName}";
  # Basic configuration
  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
