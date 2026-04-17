{self, ...}: {
  flake.modules.nixos.base = {
    pkgs,
    config,
    ...
  }: {
    nixpkgs.config.allowUnfree = true;

    security.rtkit.enable = true;
    networking.networkmanager.enable = true;

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
      displayManager.gdm.enable = true;
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
