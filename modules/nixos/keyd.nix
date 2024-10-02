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
            control      = "oneshot(control)";
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
