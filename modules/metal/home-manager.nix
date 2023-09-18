{ root, pkgs, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.goldstein = import "${root}/home/metal/goldstein.nix";
    users.root = import "${root}/home/metal/root.nix";
    extraSpecialArgs = {
      inherit root;
    };
  };
}
