{pkgs, config, ...}: {
  nixpkgs.config.allowUnfree = true;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05";

  imports = [
    ../../lib/nix.settings.nix
    ./hardware-configuration.nix
    ./packages.nix
    ./tailscale.nix
    ./gnome.nix
    ./fonts.nix
    ./keyd.nix
    ./virtualisation.nix
    ./i18n.nix
    ./nodejs.nix
  ];

  time.timeZone = "Pacific/Auckland";
  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;

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
    nodejs.enable = true;
    firefox.enable = true;

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 5d --keep 5";
    };
  };

  services = {
    printing.enable = true;
    # FIXME cnijfilter2 build error
    # https://github.com/NixOS/nixpkgs/issues/368624
    # https://github.com/NixOS/nixpkgs/issues/368651
    # printing.drivers = with pkgs; [cnijfilter2];

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
