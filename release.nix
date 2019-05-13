{ withHoogle ? false
}:
let
  pinnedPkgs = import ./nix/pkgs-from-json.nix { json = ./nix/nixos-18-09.json; };

  customHaskellPackages = pinnedPkgs.haskellPackages.override (old: {
    overrides = pinnedPkgs.lib.composeExtensions (old.overrides or (_: _: {})) (self: super: {
      project1 = self.callCabal2nix "project1" ./project1.cabal { };
      # addditional overrides go here
    });
  });

  hoogleAugmentedPackages = import ./nix/toggle-hoogle.nix { withHoogle = withHoogle; input = customHaskellPackages; };

in
  { project1 = hoogleAugmentedPackages.project1;
  }