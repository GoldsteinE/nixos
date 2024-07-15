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
  # Unbreak xdg-desktop-portal, see `man home-configuration.nix(5)`.
  environment.pathsToLink = [ "/share/xdg-desktop-portal" "/share/applications" ];
}
