# tiny-home-manager

Manage ~ with one file.

# Prerequisites

You must have [nix](https://nixos.org) installed on your machine.

```sh
curl -L https://nixos.org/nix/install | sh
```

# Tutorial

1. Click the "Use this template" button on GitHub
2. Clone your repository onto the computer you want to configure
4. Edit the `home.nix` attr in `./shell.nix` to be how you want using the [home-manager manual](https://rycee.gitlab.io/home-manager/release-notes.html).
5. Run `nix-shell` to switch to your configuration.
