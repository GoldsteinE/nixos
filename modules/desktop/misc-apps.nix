{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # browsers
    librewolf
    chromium
    tor-browser-bundle-bin
    # messengers
    slack
    # discord
    tdesktop
    weechat
    zulip
    nheko
    # stuff
    xdg-utils
    appimage-run
    lm_sensors
    qbittorrent
    playerctl
  ];
  programs.light.enable = true;
}
