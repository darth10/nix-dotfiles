{pkgs, ...}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.auto-optimise-store = true;
  nixpkgs.config.allowUnfree = true;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05";

  imports = [
    ./hardware-configuration.nix
    ./tailscale.nix
    ./gnome.nix
    ./fonts.nix
    ./keyd.nix
    ./nh.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.loader.systemd-boot.configurationLimit = 10;

  networking.networkmanager.enable = true;
  networking.hostName = "starf0rge";

  time.timeZone = "Pacific/Auckland";

  i18n.defaultLocale = "en_NZ.UTF-8";

  i18n.extraLocaleSettings = {
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

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  users.users.darth10 = {
    isNormalUser = true;
    description = "darth10";
    extraGroups = ["networkmanager" "wheel" "libvirtd"];
    packages = with pkgs; [
      kitty
      neofetch
      aspell
      aspellDicts.en
      mise
      vlc
      veracrypt
      google-chrome
      transmission_4
      transmission_4-gtk

      # LSP servers
      bash-language-server

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

    nodejs
  ];

  virtualisation.libvirtd.enable = true;

  programs = {
    zsh.enable = true;
    firefox.enable = true;
    virt-manager.enable = true;
  };
}
