inputs @ { nixpkgs, classified, home-manager, lix-module, ... }: nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";
  modules = [
    # Lix instead of Nix
    lix-module.nixosModules.default
    # external imports
    classified.nixosModules."${system}".default
    home-manager.nixosModules.home-manager
    # common stuff
    ./modules/nix.nix
    ./modules/kmscon.nix
    ./modules/users.nix
    ./modules/cli.nix
    ./modules/rust-dev.nix
    ./modules/misc-dev.nix
    # metal-specific services
    ./modules/metal/restic.nix
    ./modules/metal/bots.nix
    ./modules/metal/certs.nix
    ./modules/metal/website.nix
    ./modules/metal/vaultwarden.nix
    ./modules/metal/socks.nix
    ./modules/metal/znc.nix
    ./modules/metal/mail.nix
    ./modules/metal/betula.nix
    ./modules/metal/matrix.nix
    ./modules/metal/minecraft.nix
    ./modules/metal/satisfactory.nix
    # metal-specific system stuff
    ./modules/metal/boot.nix
    ./modules/metal/locale.nix
    ./modules/metal/hardware.nix
    ./modules/metal/partitions.nix
    ./modules/metal/networking.nix
    ./modules/metal/security.nix
    # home-manager
    ./modules/metal/home-manager.nix
    # misc stuff, keep short
    ({ ... }: {
      system.stateVersion = "22.05";
      virtualisation.podman.enable = true;
    })
  ];
  specialArgs = {
    inherit inputs;
    root = ./.;
    system = "x86_64-linux";
  };
}
