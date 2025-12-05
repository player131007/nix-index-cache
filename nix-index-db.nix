{
  stdenvNoCC,

  nix-index,
  nix-index-cache,

  extraArgs ? "--compression=9",
}:
stdenvNoCC.mkDerivation {
  name = "nix-index-db";
  preferLocalBuild = true;

  nativeBuildInputs = [
    nix-index
    nix-index-cache
  ];

  __structuredAttrs = true;
  unsafeDiscardReferences.out = true;

  buildCommand = /* bash */ ''
    # TODO: https://github.com/nix-community/nix-index/pull/285
    cp ${nix-index-cache}/paths.cache .
    chmod +w paths.cache
    nix-index ${extraArgs} --path-cache --db=$out
  '';
}
