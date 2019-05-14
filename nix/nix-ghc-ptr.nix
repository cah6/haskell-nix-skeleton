{
  hieVer = "ghc864";
  pinnedPkgs = import ./pkgs-from-json.nix { json = ./pkgs/nix-ghc864.json; };
}