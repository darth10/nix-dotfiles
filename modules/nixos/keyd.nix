{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    keyd
  ];

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
        settings = {
          main = {
            shift        = "oneshot(shift)";
            # TODO This currently requires disabling the super key binding in
            # gnome, using: `gsettings set org.gnome.mutter overlay-key ""`.
            # This will be handled when dconf config is moved to nix.
            meta         = "oneshot(meta)";
            control      = "oneshot(control)";
            capslock     = "oneshot(control)";
            alt          = "oneshot(alt)";
            rightcontrol = "oneshot(alt)";
            rightalt     = "oneshot(control)";
          };
        };
      };
    };
  };
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';
}
