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
    blog.url = "github:GoldsteinE/blog";
    inftheory-slides.url = "github:GoldsteinE/inftheory-slides";
    anti-emoji.url = "github:GoldsteinE/anti-emoji-bot";
    r9ktg.url = "github:GoldsteinE/r9ktg";
    perlsub.url = "github:GoldsteinE/perlsub";
    simple-nixos-mailserver.url = "github:GoldsteinE/simple-nixos-mailserver";
  };

  outputs = inputs: import ./common/conftpl.nix "metal" false inputs;
}
