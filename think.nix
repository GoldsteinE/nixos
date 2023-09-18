inputs @ { nixpkgs, classified, home-manager, ... }: nixpkgs.lib.nixosSystem rec {
  system = "x86_64-linux";
  modules = [
    # external imports
    classified.nixosModules."${system}".default
    home-manager.nixosModules.home-manager
    # common stuff
    ./modules/nix.nix
    ./modules/kmscon.nix
    ./modules/users.nix
    ./modules/cli.nix
    ./modules/activation-diff.nix
    ./modules/rust-dev.nix
    ./modules/misc-dev.nix
    # desktop-specific stuff
    ./modules/desktop/locale.nix
    ./modules/desktop/fonts.nix
    ./modules/desktop/btrbk.nix
    ./modules/desktop/work-vpn.nix
    ./modules/desktop/jupyter.nix
    ./modules/desktop/security.nix
    ./modules/desktop/xorg.nix
    ./modules/desktop/wired.nix
    ./modules/desktop/pipewire.nix
    ./modules/desktop/steam.nix
    ./modules/desktop/dev-tools.nix
    ./modules/desktop/misc-apps.nix
    # machine-specific stuff
    ./modules/think/boot.nix
    ./modules/think/hardware.nix
    ./modules/think/partitions.nix
    ./modules/think/networking.nix
    # home-manager
    ./modules/think/home-manager.nix
    # misc stuff, keep short
    ({ ... }: {
      system.stateVersion = "22.05";
      virtualisation.podman.enable = true;
      virtualisation.docker.enable = true;
    })
  ];
  specialArgs = {
    inherit inputs;
    root = ./.;
  };
}
