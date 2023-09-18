{ pass, ... }: {
  programs.password-store = {
    enable = true;
    package = pass;
  };
  services.pass-secret-service.enable = true;
}
