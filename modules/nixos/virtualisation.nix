{self, ...}: {
  flake.modules.nixos.virtualisation = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      docker-compose
    ];

    virtualisation = {
      docker.enable = true;

      libvirtd = {
        enable = true;
        qemu.vhostUserPackages = [pkgs.virtiofsd];
      };
    };

    programs.virt-manager.enable = true;

    users.users.${self.settings.username}.extraGroups = ["docker" "libvirtd"];
  };
}
