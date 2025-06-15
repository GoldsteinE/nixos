{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0-3.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
    # wired-notify.url = "github:toqozz/wired-notify/master";
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      # Doesn't work with latest nixpkgs for some reason.
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    fw-fanctrl = {
      url = "github:TamtamHero/fw-fanctrl/packaging/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    passnag = {
      url = "github:GoldsteinE/passnag";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # for server
    blog.url = "github:GoldsteinE/blog";
    ln-s.url = "sourcehut:~goldstein/ln-s";
    inftheory-slides.url = "github:GoldsteinE/inftheory-slides";
    anti-emoji.url = "github:GoldsteinE/anti-emoji-bot";
    r9ktg.url = "github:GoldsteinE/r9ktg";
    perlsub.url = "github:GoldsteinE/perlsub";
    perlsub.inputs.nixpkgs.follows = "nixpkgs";
    tg-vimhelpbot.url = "github:pro-vim/tg-vimhelpbot";
    simple-nixos-mailserver.url = "github:GoldsteinE/simple-nixos-mailserver";
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };
  outputs = inputs: {
    nixosConfigurations.think = (import ./think.nix) inputs;
    nixosConfigurations.gear = (import ./gear.nix) inputs;
    nixosConfigurations.metal = (import ./metal.nix) inputs;
  };
}
