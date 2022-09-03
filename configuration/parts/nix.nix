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
      inputs.neovim-nightly-overlay.overlay
      inputs.rust-overlay.overlays.default
      (final: prev: {
        gnupg = prev.gnupg.overrideAttrs (old: if old.version == "2.3.7" then {
          patches = old.patches ++ [(final.fetchpatch {
            name = "fix-yubikey.patch";
            url = "https://git.gnupg.org/cgi-bin/gitweb.cgi?p=gnupg.git;a=patch;h=f34b9147eb3070bce80d53febaa564164cd6c977;hp=95651d1a4fec9bc5e36f623b2cdcc6a35e0c30bb";
            sha256 = "sha256-KD8H6N9oGx+85SetHx1OJku28J2dmsj/JkJudknCueU=";
          })];
        }
        else {});
      })
    ];
  };
}
