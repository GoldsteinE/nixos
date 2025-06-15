{ ... }: {
  hardware.openrazer = {
    # https://github.com/NixOS/nixpkgs/issues/414604
    enable = false;
    users = [ "goldstein" ];
  };
}
