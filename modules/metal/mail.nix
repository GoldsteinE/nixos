{ pkgs, inputs, root, ... }: {
  imports = [
    inputs.simple-nixos-mailserver.nixosModule
  ];

  classified.files = {
    mailpassword.encrypted = "${root}/secrets/metal/mailpassword";
  };

  systemd.services.classified.before = [
    "postfix.service"
    "dovecot2.service"
  ];

  mailserver = {
    enable = true;
    stateVersion = 1;

    enableImap = false;
    enableSubmission = false;
    enablePop3 = false;
    enablePop3Ssl = false;
    localDnsResolver = false;

    fqdn = "mail.goldstein.rs";
    sendingFqdn = "goldstein.rs";
    domains = [ "goldstein.rs" "ham.goldstein.rs" "goldstein.lol" "tty5.dev" ];
    hierarchySeparator = "/";

    sieveDirectory = "/srv/mail/sieve";
    dkimKeyDirectory = "/srv/dkim"; # not in /srv/mail because of permissions issues
    mailDirectory = "/srv/mail/vmail";
    useFsLayout = true;

    dkimKeyBits = 2048;
    certificateScheme = "acme";
    acmeCertificateName = "goldstein.rs";

    fullTextSearch = {
      enable = true;
      memoryLimit = 1024; # MiB
    };

    loginAccounts = {
      "root@goldstein.rs" = {
        hashedPasswordFile = "/var/secrets/mailpassword";
        aliases = [
          "postmaster@goldstein.rs"
          "postmaster@mail.goldstein.rs"
          "abuse@goldstein.rs"
          "abuse@mail.goldstein.rs"
          "me@goldstein.rs"
          "@ham.goldstein.rs"
          "@goldstein.rs"
          "@goldstein.lol"
          "@tty5.dev"
        ];
      };
    };
  };

  services.postfix.networks = [
    "127.0.0.1/32"
    "[::1]/128"
  ];
  services.postfix.config = {
    smtp_tls_security_level = "dane";
    smtp_dns_support_level = "dnssec";
  };

  services.rspamd.extraConfig = ''
    actions {
      reject = null; # Disable rejects, default is 15
      greylist = 30; # Disable greylisting
      add_header = 6; # Add header when reaching this score
    }
  '';

  services.roundcube = {
    enable = true;
    hostName = "mail.goldstein.rs";
    extraConfig = ''
      # unencrypted IMAP is unavailable
      $config['default_host'] = 'ssl://goldstein.rs:993';
      # unencrypted SMTP is available but still undesirable for general reasons
      $config['smtp_server'] = 'ssl://goldstein.rs:465';
      # I'm alone here, so allow user to manage identities freely
      $config['identities_level'] = 0;
      # Dovecot2 requires username to be suffixed with domain, like `root@goldstein.rs`
      $config['username_domain'] = 'goldstein.rs';
    '';
  };
  # Group `nginx` doesn't exist on this setup
  services.phpfpm.pools.roundcube.settings."listen.group" = "nogroup";
}
