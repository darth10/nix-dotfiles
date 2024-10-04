## Installation

- For SSH, either:
  - Generate a new SSH key using `ssh-keygen`.
    Be sure to import the new SSH key into your GitHub account.
  - Import an existing SSH key using `ssh-add`.
    You can use `ssh-add -l` to view all valid SSH keys.
- Install Nix using the [Determinate Nix installer][nix-installer]:
  ```sh
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  ```
- Clone the repository and run `scripts/install`:
  ```sh
  nix shell nixpkgs#git --extra-experimental-features 'nix-command flakes'
  git clone --recursive git@github.com:darth10/nix-dotfiles.git ~/.nix-dotfiles
  cd ~/.nix-dotfiles
  ./install.sh
  ```
- For VPN, download and import [OpenVPN configuration from PIA][openvpn-pia].

[nix-installer]: https://github.com/DeterminateSystems/nix-installer
[openvpn-pia]: https://www.privateinternetaccess.com/openvpn/openvpn.zip
