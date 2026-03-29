{...}: {
  flake.modules.homeManager.fonts = {
    pkgs,
    lib,
    ...
  }: let
    consolas-ligaturized = pkgs.stdenvNoCC.mkDerivation {
      pname = "consolas-ligaturized";
      version = "3";

      src = pkgs.fetchFromGitHub {
        owner = "somq";
        repo = "consolas-ligaturized";
        rev = "d11d670146a58b5a1ffd9f6a44cef432e1678e1e";
        hash = "sha256-uJCByvY1Aq1S+aL7dcoxDqMMWHMT4V8dJT/KdOaN9Nk=";
      };

      installPhase = ''
        install -Dm644 *.ttf -t $out/share/fonts/truetype/consolas-ligaturized
      '';

      meta = {
        description = "Consolas font with FiraCode ligatures";
        homepage = "https://github.com/somq/consolas-ligaturized";
        license = lib.licenses.ofl;
        platforms = lib.platforms.all;
      };
    };
  in {
    home.packages = with pkgs; [
      fontconfig
      nerd-fonts.fira-code
      noto-fonts-color-emoji
      vista-fonts
      consolas-ligaturized
    ];

    fonts.fontconfig.enable = true;
  };
}
