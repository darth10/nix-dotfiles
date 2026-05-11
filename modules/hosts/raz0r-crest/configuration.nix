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
        keyd
        nh
        nixSettings
        nz
        stateVersion
        tailscale
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
      kernelChannel = "stable";
      firmware.enable = true;
    };

    users.users.Aroha = {
      isNormalUser = true;
      shell = pkgs.zsh;
    };

    nix.settings.trusted-public-keys = ["starf0rge-1:Bdx7tc1Tur6SohuV/LV0JmkSItTX/fD0ZKKNCGx/3PE="];
  };
}
