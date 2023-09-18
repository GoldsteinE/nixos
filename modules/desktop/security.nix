{ pkgs, ... }: {
  classified.keys.default = "/classified.key";
  systemd.services.classified.before = [ "network.target" ];

  security = {
    rtkit.enable = true;
    pam.loginLimits = [
      {
        domain = "goldstein";
        item = "memlock";
        type = "hard";
        value = "1048576";
      }
    ];
    pam.yubico = {
      enable = true;
      mode = "challenge-response";
      challengeResponsePath = "/var/yubico";
    };
    sudo.extraConfig = ''
      Defaults timestamp_timeout = 0
    '';
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "qt";
    enableSSHSupport = true;
  };

  # daemon for yubikey
  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];
}
