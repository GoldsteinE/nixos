{ ... }: {
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
}
