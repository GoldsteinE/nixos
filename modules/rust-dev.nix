{ pkgs, inputs, ... }: {
  nixpkgs.overlays = [ inputs.fenix.overlays.default ];
  environment.systemPackages = with pkgs; [
    (fenix.complete.withComponents [
      "rustc"
      "cargo"
      "rustfmt"
      "rust-src"
      "rust-analyzer"
      "clippy"
      "miri"
    ])
    cargo-mommy
    cargo-edit
    sccache
  ];
}
