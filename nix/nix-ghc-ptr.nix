{
  hieVer = "ghc843";
  pinnedPkgs = import ./pkgs-from-json.nix { json = ./pkgs/nix-ghc843.json; };
}