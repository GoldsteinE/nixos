{ root, ... }: {
  classified.files."vaultwarden.env".encrypted = "${root}/secrets/metal/vaultwarden.env";
  services.vaultwarden = {
    enable = true;
    environmentFile = "/var/secrets/vaultwarden.env";
    config = {
      DOMAIN = "https://vault.goldstein.lol";
      SIGNUPS_ALLOWED = false;
      ROCKET_PORT = "54717";
      SMTP_HOST = "localhost";
      SMTP_FROM = "vault@goldstein.lol";
      # hopefully noone is eavedropping on localhost lol
      SMTP_SECURITY = "off";
    };
  };
}
