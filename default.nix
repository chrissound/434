{ sources ? import ./nix/sources.nix
, compiler ? "ghc865"
} :
let
  niv = import sources.nixpkgs {
    overlays = [
      (_ : _ : { niv = import sources.niv {}; })
    ] ;
    config = {
      allowBroken = true;
    };
  };
  pkgs = niv.pkgs;
  myHaskellPackages = pkgs.haskell.packages.${compiler}.override {
    overrides = self: super: rec {
      webdriver-w3c = pkgs.haskell.lib.dontCheck (self.callCabal2nix "webdriver-w3c" (builtins.fetchTarball {
        url = "https://hackage.haskell.org/package/webdriver-w3c-0.0.2/webdriver-w3c-0.0.2.tar.gz";
      }) {});
      script-monad = pkgs.haskell.lib.dontCheck (super.script-monad);
    };
  };
in
myHaskellPackages.callCabal2nix "HaskellNixCabalStarter" (./.) {}
