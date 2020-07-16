let

  nixpkgs-src = builtins.fetchTarball { url = "https://github.com/nixos/nixpkgs/archive/master.tar.gz"; };
  pkgs = import nixpkgs-src {};

  home-manager-src = builtins.fetchTarball { url = "https://github.com/rycee/home-manager/archive/master.tar.gz"; };
  home-manager = (import home-manager-src {inherit pkgs;}).home-manager;

  home.nix = ''
    { pkgs, ... }:
    {
      home.username = "$USER";
      home.homeDirectory = "$HOME";
      home.stateVersion = "20.09";

      programs.bash = {
        enable = true;
      };

      home.packages = [
        pkgs.cowsay
      ];
    }
  '';

in pkgs.mkShell {

  shellHook = ''
    export NIX_PATH="nixpkgs=${nixpkgs-src}:home-manager=${home-manager-src}"
    trap 'rm -f "$TMPFILE"' EXIT
    TMPFILE=$(mktemp) || exit 1
    export HOME_MANAGER_CONFIG="$TMPFILE"
    cat <<HOMENIX >$TMPFILE
    ${home.nix}
    HOMENIX
    ${home-manager}/bin/home-manager switch
    exit 0
  '';

}
