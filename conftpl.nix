hostname: { nixpkgs, home-manager, classified, ... } @ inputs: {
  nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    modules = [
      ./hardware-configuration/${hostname}.nix
      ./configuration/${hostname}.nix
      classified.nixosModules."${system}".default
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
}
