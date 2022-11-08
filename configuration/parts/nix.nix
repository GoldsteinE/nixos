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
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
    overlays = [
      inputs.rust-overlay.overlays.default
      inputs.neovim-nightly-overlay.overlay
      (final: prev: {
        python3 = prev.python3.override {
          packageOverrides = self: super: {
            # https://github.com/NixOS/nixpkgs/issues/197408
            dbus-next = super.dbus-next.overridePythonAttrs (old: {
              checkPhase = builtins.replaceStrings
                [ "not test_peer_interface" ]
                [ "not test_peer_interface and not test_tcp_connection_with_forwarding" ]
                old.checkPhase;
            });
          };
        };
      })
    ];
  };
}
