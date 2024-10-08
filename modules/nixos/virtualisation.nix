{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    virtiofsd
  ];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
}
