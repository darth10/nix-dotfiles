{ lib, inputs, ... }:

let
  system = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${system};
  pkgs-22-11 = import inputs.nixpkgs_22_11 {
    inherit system;

    config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) (map lib.getName [
        pkgs-22-11.pcloud
      ]);
  };

  pcloud = pkgs-22-11.pcloud.overrideAttrs (prev:
    let
      version = "1.14.7";
      code = "XZhPkU0Zh5gulxHfMn4j1dYBS4dh45iDQHby";
      # Use codes from: https://www.pcloud.com/release-notes/linux.html
      src = pkgs.fetchzip {
        url = "https://api.pcloud.com/getpubzip?code=${code}&filename=${prev.pname}-${version}.zip";
        hash = "sha256-fzQVuCI3mK93Y3Fwzc0WM5rti0fTZhRm+Qj1CHC8CJ4=";
      };

      appimageContents = pkgs.appimageTools.extractType2 {
        name = "${prev.pname}-${version}";
        src = "${src}/pcloud";
      };
    in
      {
        inherit version;
        src = appimageContents;
      });
in {
  environment.systemPackages = [
    pcloud
  ];
}
