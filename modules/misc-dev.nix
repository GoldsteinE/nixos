{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gcc
    clang
    mold
    nodejs
    haskell.compiler.ghc9102
    python3Packages.ipython
  ];
}
