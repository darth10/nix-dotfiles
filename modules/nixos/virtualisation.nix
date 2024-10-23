{pkgs, ...}: {
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

  users.users.darth10.extraGroups = ["docker" "libvirtd"];
}
