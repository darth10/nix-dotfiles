{
  self,
  inputs,
  ...
}: let
  hostname = "starf0rge";
in {
  flake.nixosConfigurations.${hostname} = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.modules.nixos;
      [
        base
        gnome
        keyd
        nh
        nixSettings
        nz
        stateVersion
        tailscale
        virtualisation
      ]
      ++ [
        self.modules.nixos.${hostname}
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x230
      ];
  };

  flake.modules.nixos.${hostname} = {
    pkgs,
    config,
    ...
  }: {
    networking.hostName = hostname;

    boot = {
      kernelPackages = pkgs.linuxPackages_latest;

      loader = {
        grub = {
          enable = true;
          device = "/dev/sda";
          useOSProber = true;
        };
      };

      binfmt.emulatedSystems = ["aarch64-linux"];
    };

    nix.settings.extra-platforms = config.boot.binfmt.emulatedSystems;

    services = {
      printing.enable = true;
      printing.drivers = [pkgs.cnijfilter2];
    };
  };
}
