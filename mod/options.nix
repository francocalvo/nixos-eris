{ config, options, lib, home-manager, ... }:

with lib;
with lib.my; {
  options = with types; {
    user = mkOpt attrs { };

    dotfiles = {
      dir = mkOpt path (removePrefix "/mnt"
        (findFirst pathExists (toString ../.) [
          "/home/calvo/dotfiles" # TODO: extend to etc/dotfiles
          "/etc/dotfiles"
        ]));
      binDir = mkOpt path "${config.dotfiles.dir}/bin";
      configDir = mkOpt path "${config.dotfiles.dir}/config";
      modulesDir = mkOpt path "${config.dotfiles.dir}/modules";
      themesDir = mkOpt path "${config.dotfiles.modulesDir}/themes";
    };

    # NOTE: hlissner's home configuration 
    # home = {
    #   file = mkOpt' attrs { } "Files to place directly in $HOME";
    #   configFile = mkOpt' attrs { } "Files to place in $XDG_CONFIG_HOME";
    #   dataFile = mkOpt' attrs { } "Files to place in $XDG_DATA_HOME";
    # };

    # NOTE: KubqoA's home configuration 
    home = {
      file = mkOption {
        type = attrs;
        default = { };
        description =
          "Files managed by home-manager's <option>home.file</option>";
      };
      configFile = mkOption {
        type = attrs;
        default = { };
        description =
          "Files managed by home-manager's <option>xdg.configFile</option>";
      };
      _ = mkOption {
        type = attrs;
        default = { };
        description =
          "For passing arbitrary configuration to user's home-manager config";
      };
    };

    env = mkOption {
      type = attrsOf (oneOf [ str path (listOf (either str path)) ]);
      apply = mapAttrs (n: v:
        if isList v then
          concatMapStringsSep ":" (x: toString x) v
        else
          (toString v));
      default = { };
      description = "TODO";
    };
  };

  config = {
    user = let
      defaultName = "calvo";
      user = builtins.getEnv "USER";
      name = if elem user [ "" "root" ] then defaultName else user;
    in {
      inherit name;
      description = "The primary user account";
      extraGroups = [ "wheel" ];
      isNormalUser = true;
      home = "/home/${name}";
      group = "users";
      uid = 1000;
    };

    # INFO: this is hlissner's home-manager config, but I'm not using it

    # # Install user packages to /etc/profiles instead. Necessary for
    # # nixos-rebuild build-vm to work.
    # home-manager = {
    #   useUserPackages = true;
    #
    #   # I only need a subset of home-manager's capabilities. That is, access to
    #   # its home.file, home.xdg.configFile and home.xdg.dataFile so I can deploy
    #   # files easily to my $HOME, but 'home-manager.users.hlissner.home.file.*'
    #   # is much too long and harder to maintain, so I've made aliases in:
    #   #
    #   #   home.file        ->  home-manager.users.hlissner.home.file
    #   #   home.configFile  ->  home-manager.users.hlissner.home.xdg.configFile
    #   #   home.dataFile    ->  home-manager.users.hlissner.home.xdg.dataFile
    #   users.${config.user.name} = {
    #     home = {
    #       file = mkAliasDefinitions options.home.file;
    #       # Necessary for home-manager to work with flakes, otherwise it will
    #       # look for a nixpkgs channel.
    #       stateVersion = config.system.stateVersion;
    #     };
    #     xdg = {
    #       configFile = mkAliasDefinitions options.home.configFile;
    #       dataFile = mkAliasDefinitions options.home.dataFile;
    #     };
    #   };
    # };

    # This is KubqoA. I'll try to replace it with the above version at some point
    # TODO: eliminate the need to use options.home._
    home._ = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.home.file;
      xdg.configFile = mkAliasDefinitions options.home.configFile;
    };

    home-manager.useUserPackages = true;
    home-manager.users.${config.user.name} = mkAliasDefinitions options.home;

    users.users.${config.user.name} = mkAliasDefinitions options.user._;

    nix.settings = let users = [ "root" config.user.name ];
    in {
      trusted-users = users;
      allowed-users = users;
    };

    # must already begin with pre-existing PATH. Also, can't use binDir here,
    # because it contains a nix store path.
    env.PATH = [ "$DOTFILES_BIN" "$XDG_BIN_HOME" "$PATH" ];

    environment.extraInit = concatStringsSep "\n"
      (mapAttrsToList (n: v: ''export ${n}="${v}"'') config.env);
  };
}
