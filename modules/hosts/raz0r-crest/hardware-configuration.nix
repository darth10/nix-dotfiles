{...}: {
  flake.modules.nixos."raz0r-crest" = {
    config,
    lib,
    modulesPath,
    ...
  }: {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = ["xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod"];
    boot.initrd.kernelModules = [];
    boot.kernelModules = ["kvm-intel"];
    boot.extraModulePackages = [];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/8bd1e02c-904f-4c8c-a90b-cbf5d1809de8";
      fsType = "ext4";
    };
    fileSystems."/share" = {
      device = "/dev/disk/by-uuid/8399-87F2";
      fsType = "vfat";
      options = ["uid=1000" "gid=100" "dmask=007" "fmask=117"];
    };

    swapDevices = [
      {device = "/dev/disk/by-uuid/eb99f05f-98d7-4f08-b7b4-9f0118c078d7";}
    ];

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
}
