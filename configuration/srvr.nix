{ config, pkgs, inputs, system, ... }: {
  imports = [
    inputs.simple-nixos-mailserver.nixosModule
    inputs.anti-emoji.nixosModules."${system}".default
    inputs.r9ktg.nixosModules."${system}".default
    inputs.perlsub.nixosModules."${system}".default

    ./parts/nix.nix
    ./parts/services.nix
    ./parts/goldstein.nix
    ./parts/cli.nix

    ./parts/server/boot.nix
  ];

  fileSystems."/".options = [
    "defaults"
    "compress=zstd"
  ];

  networking.hostName = "srvr";

  time.timeZone = "Etc/UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  networking.useDHCP = false;
  networking.interfaces.ens18.useDHCP = true;

  security.acme = {
    acceptTerms = true;
    certs."goldstein.rs" = {
      group = "certs";
      email = "mouse-art@ya.ru";
      dnsProvider = "luadns";
      credentialsFile = "/etc/dnscreds.env";
      extraDomainNames = [
        "*.goldstein.rs"
      ];
    };
  };

  users = {
    users.socks = {
      isSystemUser = true;
      group = "nogroup";
    };
    groups.certs = {};
  };

  services = {
    emojiBot.enable = true;
    r9ktg.enable = true;
    perlsub.enable = true;

    openssh = {
      enable = true;
      ports = [ 7643 ];
      gatewayPorts = "clientspecified";
    };

    znc = {
      enable = true;
      openFirewall = true;
      group = "certs";
      mutable = false;
      useLegacyConfig = false;
      config = {
        SSLCertFile = "/var/lib/acme/goldstein.rs/cert.pem";
        SSLKeyFile = "/var/lib/acme/goldstein.rs/key.pem";
        LoadModule = [ "adminlog" ];
        User.goldstein = {
          Admin = true;
          Nick = "GoldsteinQ";
          LoadModule = [ "chansaver" "controlpanel" ];
          Network.libera = {
            server = "irc.libera.chat +6697";
            LoadModule = [ "simple_away" "sasl" ];
            Chan = {
              "#nixos" = { Buffer = 10000; };
              "#haskell" = { Buffer = 10000; };
              "#ghc" = { Buffer = 10000; };
            };
          };
          Pass.password = {
            Method = "sha256";
            Hash = "3a3c258d345b3f5f846d2672f3c68aa1a304e53c11c687d9f7a87f62db3ca016";
            Salt = "),e4am)9QSaG-cDjwaHK";
          };
        };
      };
    };

    matrix-synapse = {
      enable = true;
      settings = {
        server_name = "goldstein.rs";
        public_baseurl = "https://matrix.goldstein.rs/";
        url_preview_enabled = false;
        database.name = "sqlite3";
      };
      extraConfigFiles = ["/etc/matrix.yml"];
    };

    nginx = let
      commonHeaders = ''
        add_header X-Hi 'to anyone reading raw HTTP :)';
        add_header X-Clacks-Overhead 'GNU Terry Pratchett';
        add_header Strict-Transport-Security max-age=31536000;
        add_header X-Frame-Options SAMEORIGIN;
        add_header X-Content-Type-Options nosniff;
        add_header Referrer-Policy strict-origin-when-cross-origin;
      '';
      csp = ''
        add_header Content-Security-Policy "default-src 'self'; base-uri 'none'; frame-ancestors 'self'; connect-src https://goldstein.rs https://*.goldstein.rs 'self'; plugin-types; object-src 'none'; style-src 'self' 'unsafe-inline' 'unsafe-eval';";
      '';
      commonHeadersWithCsp = commonHeaders + "\n" + csp;
    in {
      enable = true;
      enableReload = true;
      group = "certs";
      appendHttpConfig = ''
        ssl_stapling on; 
        ssl_session_cache shared:SSL:5m;
        sendfile on;
        gzip on;
        gzip_proxied any;
        gzip_types
          text/css
          text/javascript
          text/xml
          text/plain
          text/html;
      '';
      recommendedProxySettings = true;

      virtualHosts = {
        "goldstein.rs" = {
          root = "/srv/root";
          default = true;
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = commonHeadersWithCsp;
        };
        "blog.goldstein.rs" = {
          root = "${inputs.blog.defaultPackage.x86_64-linux}";
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = ''
            ${commonHeadersWithCsp}
            add_header X-Nix-Derivation ${inputs.blog.defaultPackage.x86_64-linux};
          '';
        };
        "inftheory.goldstein.rs" = {
          root = "${inputs.inftheory-slides.defaultPackage.x86_64-linux}";
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = commonHeadersWithCsp;
          locations."/".index = "inftheory-slides.pdf";
        };
        "matrix.goldstein.rs" = {
          forceSSL = true;
          useACMEHost = "goldstein.rs";
          extraConfig = commonHeaders;
          locations."/".proxyPass = "http://localhost:8008";
        };
        # Also auto-configured by `services.roundcube`
        "mail.goldstein.rs" = {
          enableACME = false;
          useACMEHost = "goldstein.rs";
          extraConfig = commonHeaders;
        };
      };
    };

    dante = {
      enable = true;
      config = ''
        internal: ens18 port = 19423
        external: ens18
        socksmethod: username
        client pass {
          from: 0.0.0.0/0 to: 0.0.0.0/0
          log: error
          socksmethod: username
        }
        socks pass {
          from: 0.0.0.0/0 to: 0.0.0.0/0
          command: bind connect udpassociate
          log: error connect disconnect
          socksmethod: username
        }
        socks pass {
          from: 0.0.0.0/0 to: 0.0.0.0/0
          command: bindreply udpreply
          log: error connect disconnect
        }
      '';
    };
  };

  mailserver = {
    enable = true;

    enableImap = false;
    enableSubmission = false;
    enablePop3 = false;
    enablePop3Ssl = false;
    enableManageSieve = true;
    localDnsResolver = false;

    fqdn = "mail.goldstein.rs";
    sendingFqdn = "goldstein.rs";
    domains = [ "goldstein.rs" "ham.goldstein.rs" ];
    hierarchySeparator = "/";

    sieveDirectory = "/srv/mail/sieve";
    dkimKeyDirectory = "/srv/dkim"; # not in /srv/mail because of permissions issues
    mailDirectory = "/srv/mail/vmail";
    useFsLayout = true;

    dkimExtraConfig = let trustedHosts = pkgs.writeText "opendkim-TrustedHosts" ''
      127.0.0.1
      ::1
    ''; in ''
      InternalHosts refile:${trustedHosts}
    '';

    certificateScheme = 1; # Manual
    certificateFile = "/var/lib/acme/goldstein.rs/full.pem";
    keyFile = "/var/lib/acme/goldstein.rs/key.pem";

    fullTextSearch = {
      enable = true;
      memoryLimit = 1024; # MiB
    };

    policydSPFExtraConfig = ''
      skip_addresses = 127.0.0.1,::1
    '';

    loginAccounts = {
      "root@goldstein.rs" = {
        hashedPasswordFile = "/etc/mailpassword";
        aliases = [
          "postmaster@goldstein.rs"
          "postmaster@mail.goldstein.rs"
          "abuse@goldstein.rs"
          "abuse@mail.goldstein.rs"
          "me@goldstein.rs"
          "@ham.goldstein.rs"
          "@goldstein.rs"
        ];
      };
    };
  };
  services.postfix.networks = [
    "127.0.0.1/32"
    "[::1]/128"
  ];
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
    plugins = ["managesieve"];
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
