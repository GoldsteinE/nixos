{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gcc
    clang
    mold
    nodejs
    haskell.compiler.ghc924
    python3Packages.ipython
  ];
}
