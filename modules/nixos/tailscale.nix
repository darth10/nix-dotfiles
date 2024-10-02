{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    tailscale
  ];

  services = {
    tailscale.enable = true;
    resolved.enable = true;
  };

  networking = {
    nameservers = ["100.100.100.100" "8.8.8.8"];
    search = ["taild07501.ts.net"];
  };
}
