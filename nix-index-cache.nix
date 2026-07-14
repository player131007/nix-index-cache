{
  fetchzip,
  stdenv,
  zstd,

  system ? stdenv.hostPlatform.system,
}:
let
  generated = builtins.fromJSON (builtins.readFile ./generated.json);
in
assert generated.hashes ? ${system} || throw "nix-index-cache: no cache for ${system}";
fetchzip {
  url = "https://github.com/player131007/nix-index-cache/releases/download/${generated.release}/${system}.tar.zst";
  hash = generated.hashes.${system};
  stripRoot = false;

  nativeBuildInputs = [ zstd ];
  derivationArgs = {
    __structuredAttrs = true;
    unsafeDiscardReferences.out = true;
  };
}
