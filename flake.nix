{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    naersk.url = "github:nmattia/naersk";
    rust-overlay.url = "github:oxalica/rust-overlay";
    wired-notify.url = "github:toqozz/wired-notify/master";
    t.url = "github:GoldsteinE/flake-templates";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    simp.url = "github:Kl4rry/simp";
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
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      conf = hostname: {
        nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          modules = [
            ./hardware-configuration/${hostname}.nix
            ./configuration.nix
            inputs.classified.nixosModules."${system}".default
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.goldstein = import ./home.nix;
                extraSpecialArgs = { dotfiles = inputs.dotfiles; };
              };
            }
          ];
          specialArgs = {
            inputs = inputs;
            system = "x86_64-linux";
          };
        };
      };
    in
    conf "think";
}
