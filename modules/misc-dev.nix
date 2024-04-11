{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gcc
    clang
    mold
    nodejs
    haskell.compiler.ghc928
    python3Packages.ipython
  ];
}
