{ pkgs }:
let
  nix-index-cache = pkgs.callPackage ./nix-index-cache.nix {
    inherit (pkgs.stdenv.hostPlatform) system;
  };
in
{
  inherit nix-index-cache;

  nix-index-db = pkgs.callPackage ./nix-index-db.nix { inherit nix-index-cache; };
}
