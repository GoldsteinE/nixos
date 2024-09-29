{ root, inputs, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.goldstein = import "${root}/home/gear/goldstein.nix";
    users.root = import "${root}/home/gear/root.nix";
    extraSpecialArgs = {
      inherit root inputs;
    };
  };
  # Unbreak xdg-desktop-portal, see `man home-configuration.nix(5)`.
  environment.pathsToLink = [ "/share/xdg-desktop-portal" "/share/applications" ];
}
