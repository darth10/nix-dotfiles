## Installation

- For SSH, either:
  - Generate a new SSH key using `ssh-keygen`.
    Be sure to import the new SSH key into your GitHub account.
  - Import an existing SSH key using `ssh-add`.
    You can use `ssh-add -l` to view all valid SSH keys.
- Enable `nix-command` and `flakes` features:
  - On any OS other than NixOS, install Nix using the
    [Determinate Nix installer][nix-installer]:

    ```sh
    curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
    ```
  - On NixOS, add the following to `/etc/nixos/configuration.nix` and run `sudo nixos-rebuild switch`:
    ```nix
    nix = {
      package = pkgs.nixFlakes;
      extraOptions = "experimental-features = nix-command flakes";
    };
    ```
- Clone the repository and run `scripts/install`:
  ```sh
  nix shell nixpkgs#git --extra-experimental-features 'nix-command flakes'
  git clone --recursive git@github.com:darth10/nix-dotfiles.git ~/.nix-dotfiles
  cd ~/.nix-dotfiles
  ./install.sh
  ```
- For VPN, download and import [OpenVPN configuration from PIA][openvpn-pia].

## Remote deployment

Use the `maelstrom` flake:
``` sh
nix run nixpkgs#deploy-rs -- .#maelstrom.home-manager --hostname <HOSTNAME>
```
You can use the `--skip-checks` option to speed up deployment.

[nix-installer]: https://github.com/DeterminateSystems/nix-installer
[openvpn-pia]: https://www.privateinternetaccess.com/openvpn/openvpn.zip
