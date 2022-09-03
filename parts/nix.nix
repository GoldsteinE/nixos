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
            url = "https://gist.githubusercontent.com/GoldsteinE/529ebe029af14d43b4cf4cbb521b9869/raw/6b9415160a40dd4c6517831416e29c5d70971743/gpg.patch";
            sha256 = "sha256-KD8H6N9oGx+85SetHx1OJku28J2dmsj/JkJudknCueU=";
          })];
        }
        else {});
      })
    ];
  };
}
