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
    ## stuff
    xdg-utils
    appimage-run
    lm_sensors
    qbittorrent
    playerctl
    localsend
    kapow

    # pass proxy to signal
    (signal-desktop.overrideAttrs (self: old: {
        postFixup = ''
          substituteInPlace $out/share/applications/signal.desktop \
            --replace-fail 'Exec=' 'Exec=env HTTP_PROXY=socks5://127.0.0.1:34635 HTTPS_PROXY=socks5://127.0.0.1:34635 '
        '';
    }))

    # unfuck element (proxy + force libsecret)
    (element-desktop.overrideAttrs (self: old: {
      desktopItems = [((builtins.elemAt old.desktopItems 0).override {
        exec = "env HTTP_PROXY=socks5://127.0.0.1:34635 HTTPS_PROXY=socks5://127.0.0.1:34635 element-desktop --password-store=gnome-libsecret %u";
      })];
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
