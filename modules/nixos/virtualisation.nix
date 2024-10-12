{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    docker-compose
    virtiofsd
  ];

  virtualisation.docker.enable = true;
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  users.users.darth10.extraGroups = ["docker" "libvirtd"];
}
