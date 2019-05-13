let 
  pinnedPkgs = import ./nix/pkgs-from-json.nix { json = ./nix/nixos-18-09.json; };
  myPackages = (import ./release.nix { withHoogle = true; } );
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};

  projectDrvEnv = myPackages.project1.env.overrideAttrs (oldAttrs: rec {
    buildInputs = oldAttrs.buildInputs ++ [ 
      pinnedPkgs.haskellPackages.cabal-install
      pinnedPkgs.haskellPackages.hlint
      all-hies.versions.ghc843
      ];
    shellHook = ''
      export USERNAME="christian.henry"
      export HIE_HOOGLE_DATABASE="$NIX_GHC_LIBDIR/../../share/doc/hoogle/index.html"
    '';
  });
in 
  projectDrvEnv