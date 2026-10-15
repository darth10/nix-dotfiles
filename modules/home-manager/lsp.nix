{...}: {
  flake.modules.homeManager.lsp = {pkgs, ...}: {
    home.packages = with pkgs; [
      bash-language-server
      clojure-lsp
      nil
      yaml-language-server
      vscode-langservers-extracted
    ];
  };
}
