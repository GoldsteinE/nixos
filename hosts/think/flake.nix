{
  inputs = {
    # These should be the same for every host
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    naersk.url = "github:nmattia/naersk";
    classified = {
      url = "github:GoldsteinE/classified";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        naersk.follows = "naersk";
      };
    };
    dotfiles = {
      url = "github:GoldsteinE/dotfiles";
      flake = false;
    };
    t.url = "github:GoldsteinE/flake-templates";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # These can differ
    rust-overlay.url = "github:oxalica/rust-overlay";
    wired-notify.url = "github:toqozz/wired-notify/master";
    simp.url = "github:Kl4rry/simp";
  };

  outputs = inputs: import ./common/conftpl.nix "think" inputs;
}
