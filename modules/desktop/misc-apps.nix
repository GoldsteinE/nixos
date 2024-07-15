{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # browsers
    chromium
    tor-browser-bundle-bin
    # messengers
    slack
    discord
    tdesktop
    hexchat
    zulip
    # stuff
    appimage-run
    lm_sensors
    qbittorrent
    playerctl
    vlc
  ];
}
