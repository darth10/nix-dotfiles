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
    curl -fsSL https://install.determinate.systems/nix | sh -s -- install
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
- Ensure that your `$HOME` directory is clean using [xdg-ninja][xdg-ninja].

## Remote deployment

- Ensure that:
  - `nix-store` is available over SSH. On a fresh Nix installation, run:
     ``` sh
     % cat >> ~/.zshenv
     PATH=$PATH:/nix/var/nix/profiles/default/bin
     ```
  - Nix config (`/etc/nix/nix.custom.conf` or `/etc/nix/nix.conf`) has:
    ```conf
    trusted-users = @sudo
    use-xdg-base-directories = true
    ```

- Use the `maelstrom.home-manager` flake output:
``` sh
nix run nixpkgs#deploy-rs -- .#maelstrom.home-manager --hostname <HOSTNAME>
```
You can use the `--skip-checks` option to speed up deployment.

[nix-installer]: https://github.com/DeterminateSystems/nix-installer
[xdg-ninja]: https://github.com/b3nj5m1n/xdg-ninja 
