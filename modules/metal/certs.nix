{ root, ... }: {
  security.acme = {
    acceptTerms = true;
    certs."goldstein.rs" = {
      group = "certs";
      email = "mouse-art@ya.ru";
      dnsProvider = "luadns";
      credentialsFile = "/var/secrets/dnscreds.env";
      extraDomainNames = [
        "*.goldstein.rs"
        "neglected.space"
        "*.neglected.space"
      ];
    };
  };
  users.groups.certs = {};
  classified.files = {
    "dnscreds.env" = {
      encrypted = "${root}/secrets/metal/dnscreds.env";
      user = "acme";
    };
  };
  systemd.services.classified.before = [
    "acme-goldstein.rs.service"
  ];
}
