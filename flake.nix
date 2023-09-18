{
  inputs = {
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
    # for desktop
    wired-notify.url = "github:toqozz/wired-notify/master";
    # for server
    blog.url = "github:GoldsteinE/blog";
    inftheory-slides.url = "github:GoldsteinE/inftheory-slides";
    anti-emoji.url = "github:GoldsteinE/anti-emoji-bot";
    r9ktg.url = "github:GoldsteinE/r9ktg";
    perlsub.url = "github:GoldsteinE/perlsub";
    tg-vimhelpbot.url = "github:pro-vim/tg-vimhelpbot";
    simple-nixos-mailserver.url = "github:GoldsteinE/simple-nixos-mailserver";
  };
  outputs = inputs: {
    nixosConfigurations.think = (import ./think.nix) inputs;
    nixosConfigurations.metal = (import ./metal.nix) inputs;
  };
}
