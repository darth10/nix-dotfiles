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
        stateVersion
        tailscale
        virtualisation
      ]
      ++ [
        self.modules.nixos.${hostname}
        inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x230
      ];
  };

  flake.modules.nixos.${hostname} = {pkgs, ...}: {
    time.timeZone = "Pacific/Auckland";
    networking.hostName = hostname;

    services = {
      xserver.xkb = {
        layout = "nz";
        variant = "";
      };

      displayManager.gdm.enable = true;

      printing.enable = true;
      printing.drivers = [pkgs.cnijfilter2];
    };

    i18n = {
      defaultLocale = "en_NZ.UTF-8";

      extraLocaleSettings = {
        LC_ADDRESS = "en_NZ.UTF-8";
        LC_IDENTIFICATION = "en_NZ.UTF-8";
        LC_MEASUREMENT = "en_NZ.UTF-8";
        LC_MONETARY = "en_NZ.UTF-8";
        LC_NAME = "en_NZ.UTF-8";
        LC_NUMERIC = "en_NZ.UTF-8";
        LC_PAPER = "en_NZ.UTF-8";
        LC_TELEPHONE = "en_NZ.UTF-8";
        LC_TIME = "en_NZ.UTF-8";
      };
    };
  };
}
