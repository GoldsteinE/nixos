# TODO: make a proper module
{ pkgs, ... }:

let
  # Waiting for https://github.com/NixOS/nixpkgs/pull/269921 to land
  betula-pkg = pkgs.buildGoModule rec {
    pname = "betula";
    version = "1.1.0";

    src = pkgs.fetchFromSourcehut {
      owner = "~bouncepaw";
      repo = "betula";
      rev = "v${version}";
      hash = "sha256-MH6YeWG94YVBgx5Es3oMJ9A/hAPPBXpAcIdCJV3HX78=";
    };
    vendorHash = "sha256-wiMIhoSO7nignNWY16OpDYZCguRbcEwwO/HggKSC5jM=";

    CGO_ENABLED = 1;
    # These tests use internet, so are failing in Nix build.
    # See also: https://todo.sr.ht/~bouncepaw/betula/91
    checkFlags = "-skip=TestTitles|TestHEntries";
  };
in
{
  users.users.betula = {
    group = "nogroup";
    isSystemUser = true;
  };
  systemd.services.betula-links = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${betula-pkg}/bin/betula -port 4370 /srv/betula/links.betula";
      User = "betula";
      Group = "nogroup";
    };
  };
}

