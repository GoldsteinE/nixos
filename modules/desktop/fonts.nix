{ pkgs, ... }: {
  fonts.enableDefaultPackages = false;
  fonts.packages = with pkgs; [
    roboto
    noto-fonts
    noto-fonts-cjk-sans
    font-awesome
    material-icons
    dejavu_fonts
    freefont_ttf
    gyre-fonts
    liberation_ttf
    open-sans
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    twitter-color-emoji
  ];
  # for programs that can't into fontconfig
  fonts.fontDir.enable = true;
}
