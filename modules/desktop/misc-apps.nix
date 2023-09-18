{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # browsers
    firefox
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
    electrum
    lm_sensors
    qbittorrent
    playerctl
    vlc
  ];
}
