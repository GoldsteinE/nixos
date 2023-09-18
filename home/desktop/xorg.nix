{ pkgs, pass, tmpfilesGenRule, root, ... }: {
  imports = [
    "${root}/home/desktop/bspwm.nix"
    "${root}/home/desktop/polybar.nix"
  ];
  systemd.user.tmpfiles.rules = map tmpfilesGenRule [
    ".config/rofi"
    ".config/wired"
    ".config/yubikey-touch-detector"
    ".config/bspwm/desktop.jpg"
    ".config/alacritty"
  ];
  home = {
    file = {
      ".local/bin/rofi-otp" = {
        executable = true;
        text = ''
          #!${pkgs.bash}/bin/bash
          set -euo pipefail
          cd $PASSWORD_STORE_DIR/otp
          ${pkgs.fd}/bin/fd -t f --strip-cwd-prefix \
            | ${pkgs.gnused}/bin/sed 's/\.gpg$//' \
            | ${pkgs.rofi}/bin/rofi \
              -theme ${pkgs.rofi}/share/rofi/themes/android_notification \
              -dmenu -i \
              -font 'Noto Sans 32' \
            | ${pkgs.findutils}/bin/xargs -I{} ${pass}/bin/pass otp "otp/{}" \
            | ${pkgs.findutils}/bin/xargs ${pkgs.xdotool}/bin/xdotool type
        '';
      };
      ".local/bin/put-password" = {
        executable = true;
        text = ''
          #!${pkgs.bash}/bin/bash
          set -euo pipefail
          ${pass}/bin/pass show "$1" | ${pkgs.findutils}/bin/xargs ${pkgs.xdotool}/bin/xdotool type
        '';
      };
    };
  };
}
