{ root, inputs, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.goldstein = import "${root}/home/think/goldstein.nix";
    users.root = import "${root}/home/think/root.nix";
    extraSpecialArgs = {
      inherit root inputs;
    };
  };
}
