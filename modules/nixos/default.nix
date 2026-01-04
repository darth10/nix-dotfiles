{pkgs, config, ...}: {
  nixpkgs.config.allowUnfree = true;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05";

  imports = [
    ../../lib/nix.settings.nix
    ./hardware-configuration.nix
    ./packages.nix
    ./display.nix
    ./tailscale.nix
    ./fonts.nix
    ./keyd.nix
    ./virtualisation.nix
    ./i18n.nix
    ./nodejs.nix
  ];

  time.timeZone = "Pacific/Auckland";
  security.rtkit.enable = true;

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

  networking = {
    hostName = "starf0rge";
    networkmanager.enable = true;
  };

  users.users.darth10 = {
    isNormalUser = true;
    description = "darth10";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
  };

  programs = {
    zsh.enable = true;
    nodejs.enable = false;
    firefox.enable = true;

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 5d --keep 5";
    };
  };

  services = {
    printing.enable = true;
    # printing.drivers = with pkgs; [cnijfilter2];

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
}
