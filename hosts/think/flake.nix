{
  inputs = {
    # These should be the same for every host
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    naersk.url = "github:nmattia/naersk";
    fenix.url = "github:nix-community/fenix";
    classified = {
      url = "github:GoldsteinE/classified";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        naersk.follows = "naersk";
      };
    };
    t.url = "github:GoldsteinE/flake-templates";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # These can differ
    wired-notify.url = "github:toqozz/wired-notify/master";
    simp.url = "github:Kl4rry/simp";
  };

  outputs = inputs: import ./common/conftpl.nix "think" true inputs;
}
