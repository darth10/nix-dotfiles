{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    gnomeExtensions.hue-lights
    gnomeExtensions.unite
    gnomeExtensions.keyboard-modifiers-status
    gnomeExtensions.another-window-session-manager
  ];

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb = {
      layout = "nz";
      variant = "";
    };
  };
}
