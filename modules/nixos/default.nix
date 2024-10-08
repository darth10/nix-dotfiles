{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05";

  imports = [
    ../nix/settings.nix
    ./hardware-configuration.nix
    ./tailscale.nix
    ./gnome.nix
    ./fonts.nix
    ./keyd.nix
    ./nh.nix
    ./nodejs.nix
  ];

  time.timeZone = "Pacific/Auckland";
  security.rtkit.enable = true;
  hardware.pulseaudio.enable = false;
  virtualisation.libvirtd.enable = true;

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

  users.users.darth10 = {
    isNormalUser = true;
    description = "darth10";
    extraGroups = ["networkmanager" "wheel" "libvirtd"];
    packages = with pkgs; [
      kitty
      emacs
      neofetch
      aspell
      aspellDicts.en
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

  environment.systemPackages = with pkgs; [
    git
    gnupg
    fd
    (ripgrep.override {withPCRE2 = true;})
    dig.dnsutils
    manix
    direnv

    (pass.withExtensions (ext:
      with ext; [
        pass-audit
      ]))
    pass

    virtiofsd
  ];

  programs = {
    zsh.enable = true;
    nodejs.enable = true;
    firefox.enable = true;
    virt-manager.enable = true;
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
