{ inputs, ... }: {
  nix = {
    registry = {
      n.flake = inputs.nixpkgs;
      nixpkgs.flake = inputs.nixpkgs;
      templates.flake = inputs.t;
      t.flake = inputs.t;
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    nixPath = [
      "nixpkgs=${inputs.nixpkgs}"
      "nixos-config=/etc/nixos/configuration.nix"
    ];
    settings = {
      connect-timeout = 5;
      log-lines = 25;
      fallback = true;
      warn-dirty = false;
      auto-optimise-store = true;
      keep-outputs = true;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      inputs.fenix.overlays.default
    ];
  };
}
