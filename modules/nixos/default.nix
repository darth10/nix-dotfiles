{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05";

  imports = [
    ../../lib/nix.settings.nix
    ./hardware-configuration.nix
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
    loader = {
      grub.enable = true;
      grub.device = "/dev/sda";
      grub.useOSProber = true;
      systemd-boot.configurationLimit = 10;
    };
  };

  networking = {
    hostName = "starf0rge";
    networkmanager.enable = true;
  };

  users.users.darth10 = {
    isNormalUser = true;
    description = "darth10";
    extraGroups = ["networkmanager" "wheel"];
    # TODO move to environment.systemPackages
    packages = with pkgs; [
      kitty
      emacs
      neofetch
      mise
      spotify
      vlc
      veracrypt
      google-chrome
      transmission_4
      transmission_4-gtk

      # LSP servers
      bash-language-server
      clojure-lsp
      nil

      # Games
      openra
      openttd
    ];
    shell = pkgs.zsh;
  };

  # TODO move to packages.nix
  environment.systemPackages = with pkgs;
    [
      # These packages are needed for remote editing
      git
      gnupg
      fd
      (ripgrep.override {withPCRE2 = true;})

      unzip
      dig.dnsutils
      manix
      direnv
      foliate

      (pass.withExtensions (ext:
        with ext; [
          pass-audit
        ]))
      pass
    ]
    ++ (import ../../lib/nh.nix {inherit pkgs;});

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
