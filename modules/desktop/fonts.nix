{ pkgs, ... }: {
  fonts.packages = with pkgs; [
    roboto
    noto-fonts
    noto-fonts-cjk
    font-awesome
    material-icons
    dejavu_fonts
    open-sans
    (nerdfonts.override { fonts = [ "Iosevka" "IosevkaTerm" ]; })
  ];
  # for programs that can't into fontconfig
  fonts.fontDir.enable = true;
}
