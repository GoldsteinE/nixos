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
    nheko
    # stuff
    appimage-run
    lm_sensors
    qbittorrent
    playerctl
    mpv
  ];
  programs.light.enable = true;
}
