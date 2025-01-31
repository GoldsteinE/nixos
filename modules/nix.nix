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
      permittedInsecurePackages = [
        "olm-3.2.16"
      ];
    };
  };

  # useless + broken with Lix
  system.tools.nixos-option.enable = false;

  nixpkgs.overlays = [(final: prev: {
    # fix nixd
    nixt = prev.nixt.override {
      nix = final.nixVersions.nix_2_24;
    };
    nixd = prev.nixt.override {
      nix = final.nixVersions.nix_2_24;
    };
    linuxKernel = inputs.nixpkgs-small.legacyPackages.x86_64-linux.linuxKernel;
  })];
}
