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

    # unfuck signal
    # see: https://github.com/signalapp/Signal-Desktop/issues/6368
    (signal-desktop.overrideAttrs (self: old: {
      patches = old.patches ++ [(pkgs.writeText "sway-window.patch" ''
diff --git a/app/main.ts b/app/main.ts
index 42c8df9d3..b741e9b36 100644
--- a/app/main.ts
+++ b/app/main.ts
@@ -691,7 +691,7 @@ async function createWindow() {
     : DEFAULT_HEIGHT;
 
   const windowOptions: Electron.BrowserWindowConstructorOptions = {
-    show: false,
+    show: true,
     width,
     height,
     minWidth: MIN_WIDTH,
        '')];
        postFixup = ''
          substituteInPlace $out/share/applications/signal.desktop \
            --replace-fail 'Exec=' 'Exec=env HTTP_PROXY=socks5://127.0.0.1:34635 HTTPS_PROXY=socks5://127.0.0.1:34635 '
        '';
    }))

    # unfuck telegram
    (telegram-desktop.overrideAttrs (self: old: {
      qtWrapperArgs = old.qtWrapperArgs ++ [
        # use platform dialogs
        "--set" "QT_QPA_PLATFORMTHEME" "flatpak"
      ];
    }))
  ];
  programs.light.enable = true;
}
