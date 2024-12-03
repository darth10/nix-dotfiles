{
  lib,
  inputs,
  ...
}: let
  system = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  pkgs-22-11 = import inputs.nixpkgs_22_11 {
    inherit system;

    config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) (map lib.getName [
        pkgs-22-11.pcloud
      ]);
  };

  # Ensure ~/.config/autostart/pcloud.desktop is recreated
  # with correct version, after updating the pcloud version.

  pcloud = pkgs-22-11.pcloud.overrideAttrs (prev: let
    version = "1.14.8";
    code = "XZxqNX5Z7nKd4XMTlkbMbnuRDuhyfL1g5efk";
    # Use codes from: https://www.pcloud.com/release-notes/linux.html
    src = pkgs.fetchzip {
      url = "https://api.pcloud.com/getpubzip?code=${code}&filename=${prev.pname}-${version}.zip";
      hash = "sha256-+uWvaNA9mCF9vkBbNnsak+h11mcl9QBamBhMzt68Rfc=";
    };

    appimageContents = pkgs.appimageTools.extractType2 {
      inherit version;

      pname = prev.pname;
      src = "${src}/pcloud";
    };
  in {
    inherit version;
    src = appimageContents;
  });
in {
  environment.systemPackages = [
    pcloud
  ];
}
