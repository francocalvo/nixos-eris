{ pkgs, config, lib, ... }:
with lib;
with lib.my;
let cfg = config.modules.dev.virt;
in {
  options.modules.dev.virt = {
    enable = mkEnableOption "Virtualisation support";
  };

  config = mkIf cfg.enable {
    programs.dconf.enable = true;

    user.extraGroups = [ "libvirtd" ];

    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      qemu_kvm
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      adwaita-icon-theme
    ];

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          swtpm.enable = true;
          ovmf.enable = true;
          ovmf.packages = [ pkgs.OVMFFull.fd ];
        };
      };
      spiceUSBRedirection.enable = true;
    };
    services.spice-vdagentd.enable = true;
  };
}
