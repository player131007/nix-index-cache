{
  pkgs,
  system ? pkgs.stdenv.hostPlatform.system,
}:
let
  generated = builtins.fromJSON (builtins.readFile ./generated.json);

  nix-index-cache = pkgs.fetchzip {
    url = "https://github.com/player131007/nix-index-cache/releases/download/${generated.release}/${system}.tar.zst";
    hash = generated.hashes.${system};
    stripRoot = false;

    nativeBuildInputs = [ pkgs.zstd ];
    derivationArgs = {
      __structuredAttrs = true;
      unsafeDiscardReferences.out = true;
    };
  };
in
assert generated.hashes ? ${system};
{
  inherit nix-index-cache;

  nix-index-db = pkgs.callPackage ./nix-index-db.nix { inherit nix-index-cache; };
}
