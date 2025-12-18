{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ## browsers
    librewolf
    chromium
    tor-browser
    ## messengers
    weechat
    thunderbird
    # zulip  # banished to old-electron-jail
    nheko
    ## stuff
    xdg-utils
    appimage-run
    lm_sensors
    qbittorrent
    playerctl
    localsend

    # pass proxy to signal
    (signal-desktop.overrideAttrs (self: old: {
        postFixup = ''
          substituteInPlace $out/share/applications/signal.desktop \
            --replace-fail 'Exec=' 'Exec=env HTTP_PROXY=socks5://127.0.0.1:34635 HTTPS_PROXY=socks5://127.0.0.1:34635 '
        '';
    }))

    # unfuck telegram
    # (telegram-desktop.overrideAttrs (self: old: {
    #   qtWrapperArgs = old.qtWrapperArgs ++ [
    #     # use platform dialogs
    #     "--set" "QT_QPA_PLATFORMTHEME" "flatpak"
    #   ];
    # }))
    telegram-desktop
  ];
  programs.light.enable = true;
}
