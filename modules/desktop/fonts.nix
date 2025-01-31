{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    roboto
    noto-fonts
    noto-fonts-cjk-sans
    font-awesome
    material-icons
    dejavu_fonts
    open-sans
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
  ];
  # for programs that can't into fontconfig
  fonts.fontDir.enable = true;
}
