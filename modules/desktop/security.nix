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
    pam = {
      yubico = {
        enable = false;
        mode = "challenge-response";
        challengeResponsePath = "/var/yubico";
        control = "sufficient";
      };
      services = {
        login.yubicoAuth = true;
        swaylock.yubicoAuth = true;
        sudo.yubicoAuth = true;
        polkit-1.yubicoAuth = true;
      };
    };
    sudo.extraConfig = ''
      Defaults timestamp_timeout = 0
    '';
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSSHSupport = true;
  };

  # daemon for yubikey
  services.pcscd.enable = true;
  services.udev.packages = [ pkgs.yubikey-personalization ];
}
