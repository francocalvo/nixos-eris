{ pkgs, lib, config, ... }:
with lib;
with lib.my;
let cfg = config.modules.d.finances;
in {
  options.modules.d.finances = {
    enable = mkEnableOption "Enable suit of finance tools";
  };

  config = mkIf cfg.enable {

    # Implicitly enable Neovim with it's configs for Beancounter
    modules.editors.neovim.enable = true;

    user = { packages = with pkgs; [ beancount-language-server fava ]; };

    environment.shellAliases = {
      bean = ''
        vim ~/Nextcloud/Finanzas/Beans/journals/2023.bean ~/Nextcloud/Finanzas/Beans/accounts.bean ~/Nextcloud/Finanzas/Beans/prices/commodities.bean ~/Nextcloud/Finanzas/Beans/main.bean
      '';
    };

  };
}
