{self, ...}: {
  flake.modules.nixos.base = {
    pkgs,
    config,
    ...
  }: {
    nixpkgs.config.allowUnfree = true;

    security.rtkit.enable = true;
    networking.networkmanager.enable = true;

    boot = {
      kernelPackages = pkgs.linuxPackages_latest;

      loader = {
        grub.enable = true;
        grub.device = "/dev/sda";
        grub.useOSProber = true;
        systemd-boot.configurationLimit = 10;
      };

      binfmt.emulatedSystems = ["aarch64-linux"];
    };

    nix.settings.extra-platforms = config.boot.binfmt.emulatedSystems;

    users.users.${self.settings.username} = {
      isNormalUser = true;
      description = self.settings.username;
      extraGroups = ["networkmanager" "wheel"];
      shell = pkgs.zsh;
    };

    programs = {
      zsh.enable = true;
      firefox.enable = true;
    };

    services = {
      xserver.enable = true;
      desktopManager.gnome.enable = true;
      pulseaudio.enable = false;

      pipewire = {
        enable = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this:
        #jack.enable = true;
        alsa = {
          enable = true;
          support32Bit = true;
        };
      };
    };
  };
}
