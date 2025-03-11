{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ## browsers
    librewolf
    chromium
    tor-browser-bundle-bin
    ## messengers
    slack
    weechat
    # zulip  # banished to old-electron-jail
    nheko
    ## stuff
    xdg-utils
    appimage-run
    lm_sensors
    qbittorrent
    playerctl

    # unfuck telegram
    (telegram-desktop.overrideAttrs (self: old: {
      # telegram shells out to `xdg-open`, which needs basically the full user env to work
      # it also needs convincing to use file dialogs via portal
      # this:
      # - re-wraps it to source `/etc/profile`, so user env is available
      # - sets `QT_QPA_PLATFORMTHEME=flatpak` so it uses portal dialogs
      postInstall = ''
        chmod +w $out/bin
        chmod +w $out/bin/telegram-desktop
        mv $out/bin/telegram-desktop $out/bin/.telegram-desktop-rewrapped
        cat > $out/bin/telegram-desktop <<EOF
        #!/bin/sh
        set -e
        . /etc/profile
        QT_QPA_PLATFORMTHEME=flatpak $unwrapped/bin/telegram-desktop "\$@"
        EOF
        chmod +x $out/bin/telegram-desktop
      '';
    }))
  ];
  programs.light.enable = true;
}
