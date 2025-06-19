{
  description = "Development environment for MCRcortex/voxy";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
    in {
      devShell = pkgs.mkShell {
        name = "voxy-dev";

        buildInputs = with pkgs; [
          openjdk21
          git
          cacert
        ];

        shellHook = ''
          export JAVA_HOME=${pkgs.openjdk21.home}
          export PATH=$JAVA_HOME/bin:$PATH
        '';
      };
    });
}
