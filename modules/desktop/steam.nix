{ pkgs, ... }: {
  programs.steam.enable = true;
  environment.systemPackages = with pkgs; [
    (steam.override {
      extraPkgs = pkgs: with pkgs; [ pango harfbuzz libthai ];
    })
  ];
}
