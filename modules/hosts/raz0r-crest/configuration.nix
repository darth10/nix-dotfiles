{
  self,
  inputs,
  ...
}: let
  hostname = "raz0r-crest";
in {
  flake.nixosConfigurations.${hostname} = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.modules.nixos;
      [
        base
        gnome
        # keyd
        nh
        nixSettings
        nz
        stateVersion
        # tailscale
        # virtualisation
      ]
      ++ [
        self.modules.nixos.${hostname}
        inputs.nixos-hardware.nixosModules.apple-t2
      ];
  };

  flake.modules.nixos.${hostname} = {pkgs, ...}: {
    networking.hostName = hostname;
    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 10;
        };

        efi = {
          efiSysMountPoint = "/boot";
          canTouchEfiVariables = true;
        };
      };
    };

    hardware.apple-t2 = {
      kernelChannel = "latest";
      firmware.enable = true;
    };

    users.users.Aroha = {
      isNormalUser = true;
      shell = pkgs.zsh;
    };

    ### TODO move to ./packages.nix
    environment.systemPackages = with pkgs; [
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      wget # TODO remove
      tree # TODO remove
      gparted

      gimp
    ];
  };
}
